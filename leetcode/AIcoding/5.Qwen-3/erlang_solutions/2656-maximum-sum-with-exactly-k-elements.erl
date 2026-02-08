-module(maximum_sum_with_exactly_k_elements).
-export([k_consecutive_ones/2]).

k_consecutive_ones(Nums, K) ->
    lists:sum(lists:sublist(lists:sort(fun(A, B) -> A > B end, Nums), K)).