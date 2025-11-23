-module(solution).
-export([largest_sum_after_k_negations/2]).

largest_sum_after_k_negations(Array, K) ->
    SortedArray = lists:sort(fun(A, B) -> A > B end, Array),
    NegatedArray = lists:map(fun(X) -> if X < 0 -> -X; true -> X end end, lists:sublist(SortedArray, K)),
    RemainingArray = lists:sublist(SortedArray, K + 1),
    lists:sum(NegatedArray) + lists:sum(RemainingArray).