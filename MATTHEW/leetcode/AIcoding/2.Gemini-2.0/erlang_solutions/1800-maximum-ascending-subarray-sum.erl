-module(maximum_ascending_subarray_sum).
-export([max_ascending_sum/1]).

max_ascending_sum(Nums) ->
    max_ascending_sum_helper(Nums, 0, 0, 0).

max_ascending_sum_helper([], _, CurrentSum, MaxSum) ->
    max(MaxSum, CurrentSum);
max_ascending_sum_helper([H|T], Prev, CurrentSum, MaxSum) ->
    if
        H > Prev ->
            max_ascending_sum_helper(T, H, CurrentSum + H, MaxSum);
        true ->
            max_ascending_sum_helper(T, H, H, max(MaxSum, CurrentSum))
    end.

max(A, B) ->
    if A > B -> A; true -> B end.