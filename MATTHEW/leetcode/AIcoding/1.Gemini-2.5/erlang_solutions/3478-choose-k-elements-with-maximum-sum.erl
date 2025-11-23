-module(solution).
-export([max_sum_k_elements/2]).

max_sum_k_elements(Nums, K) ->
    SortedDesc = lists:sort(fun(A, B) -> A >= B end, Nums),
    TopK = lists:sublist(SortedDesc, K),
    lists:sum(TopK).