-module(solution).
-export([check_possibility/1]).

check_possibility(Nums) ->
    check(Nums, 0, false).

check([], _, _) -> true;
check([_ | []], _, _) -> true;
check([A, B | Rest], Count, Changed) when A <= B -> 
    check([B | Rest], Count, Changed);
check([A, B | Rest], Count, Changed) when Count < 1 -> 
    check([B | Rest], Count + 1, true);
check([A, B | Rest], Count, Changed) when Changed =:= true -> 
    false;
check([A, B | Rest], Count, Changed) -> 
    (B =:= A) orelse (A < B) orelse (Count < 1 andalso check([B | Rest], Count + 1, true)).