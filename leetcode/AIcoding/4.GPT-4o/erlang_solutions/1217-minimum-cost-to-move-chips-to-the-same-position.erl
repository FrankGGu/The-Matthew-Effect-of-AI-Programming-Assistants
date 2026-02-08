-module(solution).
-export([minCost/1]).

minCost(positions) ->
    EvenCount = lists:foldl(fun(X, Acc) -> Acc + (X rem 2) end, 0, positions),
    OddCount = length(positions) - EvenCount,
    min(EvenCount, OddCount).

min(A, B) ->
    if
        A < B -> A;
        true -> B
    end.