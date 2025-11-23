-module(solution).
-export([largest_sum_after_k_negations/2]).

largest_sum_after_k_negations(Nums, K) ->
    Sorted = lists:sort(Nums),
    largest_sum_after_k_negations_helper(Sorted, K, 0).

largest_sum_after_k_negations_helper([], _, Sum) ->
    Sum;
largest_sum_after_k_negations_helper([H | T], K, Sum) when H < 0, K > 0 ->
    largest_sum_after_k_negations_helper(T, K - 1, Sum - H);
largest_sum_after_k_negations_helper([H | T], K, Sum) when H < 0, K == 0 ->
    largest_sum_after_k_negations_helper(T, K, Sum - H);
largest_sum_after_k_negations_helper([H | T], K, Sum) when H >= 0 andalso K > 0 ->
    if
        K rem 2 == 0 ->
            largest_sum_after_k_negations_helper(T, 0, Sum + H);
        true ->
            largest_sum_after_k_negations_helper(T, 0, Sum - H)
    end;
largest_sum_after_k_negations_helper([H | T], K, Sum) ->
    largest_sum_after_k_negations_helper(T, K, Sum + H).