-module(solution).
-export([solve/2]).

solve(Nums, K) ->
    Sorted = lists:sort(Nums),
    MinSum = min_sum(Sorted, K),
    MaxSum = max_sum(Sorted, K),
    [MinSum, MaxSum].

min_sum(Nums, K) ->
    lists:sum(lists:sublist(Nums, K)).

max_sum(Nums, K) ->
    Len = length(Nums),
    lists:sum(lists:sublist(Nums, Len - K + 1, K)).