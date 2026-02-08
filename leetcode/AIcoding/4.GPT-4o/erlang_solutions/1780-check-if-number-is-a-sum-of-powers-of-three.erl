-module(solution).
-export([checkPowersOfThree/1]).

checkPowersOfThree(N) ->
    check(N, 1).

check(0, _) -> 
    true;
check(N, Power) when N < 0 -> 
    false;
check(N, Power) -> 
    check(N - Power, Power * 3) orelse check(N, Power * 3).