-module(solution).
-export([maximum_beauty/1]).

maximum_beauty(A) ->
    Max = lists:max(A),
    Count = lists:count(fun(X) -> X =:= Max end, A),
    NewMax = Max + Count,
    NewMax.