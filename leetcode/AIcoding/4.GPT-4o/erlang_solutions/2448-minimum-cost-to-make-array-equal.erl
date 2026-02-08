-module(solution).
-export([min_cost/2]).

min_cost(N, A) ->
    HalfN = (N + 1) div 2,
    SortedA = lists:sort(A),
    Median = SortedA[HalfN - 1],
    lists:foldl(fun(X, Acc) -> Acc + abs(X - Median) end, 0, A).