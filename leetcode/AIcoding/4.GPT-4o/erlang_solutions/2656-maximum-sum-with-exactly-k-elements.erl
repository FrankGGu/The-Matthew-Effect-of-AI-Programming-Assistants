-module(solution).
-export([max_sum_k_elements/2]).

max_sum_k_elements(List, K) ->
    lists:sum(lists:sort(fun(A, B) -> A > B end, List)) - lists:sum(lists:nthtail(K, lists:sort(fun(A, B) -> A > B end, List))).