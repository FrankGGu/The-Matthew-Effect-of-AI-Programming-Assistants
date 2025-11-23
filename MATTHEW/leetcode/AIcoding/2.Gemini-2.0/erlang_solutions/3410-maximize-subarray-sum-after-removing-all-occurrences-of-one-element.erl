-module(maximize_subarray_sum).
-export([max_subarray_sum_after_removal/2]).

max_subarray_sum_after_removal(Nums, X) ->
    max_subarray_sum_after_removal(Nums, X, 0).

max_subarray_sum_after_removal([], _, MaxSum) ->
    MaxSum;
max_subarray_sum_after_removal(Nums, X, InitMaxSum) ->
    MaxSum1 = max_subarray_sum_after_removal_helper(Nums, X),
    MaxSum = max(InitMaxSum, MaxSum1),
    MaxSum.

max_subarray_sum_after_removal_helper(Nums, X) ->
    max_subarray_sum_after_removal_helper(Nums, X, 0, 0).

max_subarray_sum_after_removal_helper([], _, MaxSoFar, CurrMax) ->
    max(MaxSoFar, CurrMax);
max_subarray_sum_after_removal_helper([H|T], X, MaxSoFar, CurrMax) ->
    case H =:= X of
        true ->
            max_subarray_sum_after_removal_helper(T, X, MaxSoFar, CurrMax);
        false ->
            NewCurrMax = max(0, CurrMax + H),
            NewMaxSoFar = max(MaxSoFar, NewCurrMax),
            max_subarray_sum_after_removal_helper(T, X, NewMaxSoFar, NewCurrMax)
    end.