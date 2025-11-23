-module(solution).
-export([sum_of_distances/1]).

sum_of_distances(R) ->
    N = length(R),
    Sum = lists:foldl(fun(X, Acc) -> Acc + X end, 0, R),
    lists:map(fun(X) -> N * X - Sum end, R).