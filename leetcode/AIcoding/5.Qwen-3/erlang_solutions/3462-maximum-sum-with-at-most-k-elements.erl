-module(maximum_sum_with_at_most_k_elements).
-export([maxSum([1,2,3,4,5], 2)]).

maxSum(List, K) ->
    Sorted = lists:sort(fun(A, B) -> A > B end, List),
    TopK = lists:sublist(Sorted, K),
    lists:sum(TopK).