-module(solution).
-export([minOperations/1]).

minOperations(A) ->
    N = length(A),
    S = lists:foldl(fun(X, Acc) -> Acc bxor X end, 0, A),
    if
        S == 0 -> 0;
        true -> 1
    end.