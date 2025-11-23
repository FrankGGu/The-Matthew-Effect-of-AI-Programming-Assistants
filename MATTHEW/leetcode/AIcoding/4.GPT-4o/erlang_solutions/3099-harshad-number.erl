-module(solution).
-export([isHarshad/1]).

isHarshad(N) when N > 0 ->
    Sum = lists:sum(integer_to_list(N)),
    N rem Sum =:= 0.