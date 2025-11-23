-module(solution).
-export([largest_sum_after_k_negations/2]).

largest_sum_after_k_negations(Nums, K) ->
    Sorted = lists:sort(fun(A, B) -> A =< B end, Nums),
    Negated = negate_smallest(Sorted, K),
    lists:sum(Negated).

negate_smallest(List, 0) -> List;
negate_smallest([H | T], K) when H < 0 ->
    negate_smallest([-H | T], K - 1);
negate_smallest(List, K) when K rem 2 == 0 -> List;
negate_smallest([H | T], K) -> [-H | T].