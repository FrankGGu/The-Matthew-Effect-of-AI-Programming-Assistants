-module(solution).
-export([max_sum/2]).

max_sum(Nums, K) ->
    Sorted = lists:reverse(lists:sort(Nums)),
    TopK = lists:sublist(Sorted, K),
    lists:sum(TopK).