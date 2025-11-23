-module(max_subarray_sum_with_one_deletion).
-export([maximumSumSubarray/1]).

maximumSumSubarray(Nums) ->
    N = length(Nums),
    {MaxWithDeletion, MaxWithoutDeletion} = lists:foldl(
        fun(I, {MaxWithDel, MaxWithoutDel}) ->
            Current = lists:nth(I, Nums),
            NewMaxWithoutDel = max(Current, MaxWithoutDel + Current),
            NewMaxWithDel = max(MaxWithoutDel - Current, MaxWithDel + Current),
            {NewMaxWithDel, NewMaxWithoutDel}
        end,
        {-infinity, -infinity},
        lists:seq(1, N)
    ),
    max(MaxWithDeletion, MaxWithoutDeletion).