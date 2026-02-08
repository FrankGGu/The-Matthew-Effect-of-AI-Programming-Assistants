-module(solution).
-export([max_score_indices/1]).

max_score_indices(BinaryArray) ->
    Ones = lists:sum(BinaryArray),
    N = length(BinaryArray),
    MaxScore = Ones + 1,
    lists:filter(fun(Index) -> (Ones - lists:nth(Index + 1, BinaryArray)) + lists:nth(Index + 1, BinaryArray) == MaxScore end, lists:seq(0, N - 1)).