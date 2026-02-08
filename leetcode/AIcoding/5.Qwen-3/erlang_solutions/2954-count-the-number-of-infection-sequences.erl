-module(solution).
-export([numberOfInfectionSequences/1]).

numberOfInfectionSequences(N) ->
    Count = 1,
    lists:foldl(fun(I, Acc) -> Acc * I end, Count, lists:seq(1, N)).

lists:seq(1, N).