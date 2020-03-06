

***Balance Test
global balanceopts "bf(%15.3gc) sfmt(%15.3gc) se label noisily noeqlines nonumbers varlabels(_cons Constant, end("" ) > nolast)  starlevels(* 0.1 ** 0.05 *** 0.01)"
estpost ttest severityofcrime, by(republicanjudge ) unequal welch 
esttab . using balance_table.rtf, cell("mu_1(f(3)) mu_2(f(3)) b(f(3) star)") wide collabels("Democracy" "Republic" "Difference") noobs $balanceopts mlabels(none) eqlabels(none) legend replace mgroups(none)

***the First Stage
reg monthsinjail republicanjudge severityofcrime
 eststo regression_two
 esttab regression_two using first_stage.rtf, $tableoptions keep(republicanjudge severityofcrime) 
 
***Reduced form
reg recidivates republicanjudge severityofcrime
 
***the Second Stage
ssc install ranktest 
ivreg2 recidivates (monthsinjail = republicanjudge) severityofcrime
 eststo regression_three
 esttab regression_three using IV.rtf, $tableoptions keep(monthsinjail severityofcrime) 
