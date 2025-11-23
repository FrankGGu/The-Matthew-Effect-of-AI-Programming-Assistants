-module(maximum_score_of_spliced_array).
-export([maximum_score/2]).

maximum_score(Nums1, Nums2) ->
    S1 = lists:sum(Nums1),
    S2 = lists:sum(Nums2),
    Len = length(Nums1),

    Diff1 = [N2 - N1 || {N1, N2} <- lists:zip(Nums1, Nums2)],
    Diff2 = [N1 - N2 || {N1, N2} <- lists:zip(Nums1, Nums2)],

    MaxDiff1 = max_subarray_sum(Diff1),
    MaxDiff2 = max_subarray_sum(Diff2),

    max(S1 + MaxDiff1, S2 + MaxDiff2).

max_subarray_sum(Nums) ->
    Kadane = fun(Acc, Num) ->
        {MaxSoFar, CurrentMax} = Acc,
        NewCurrentMax = max(Num, CurrentMax + Num),
        NewMaxSoFar = max(MaxSoFar, NewCurrentMax),
        {NewMaxSoFar, NewCurrentMax}
    end,
    {Result, _} = lists:foldl(Kadane, {hd(Nums), hd(Nums)}, tl(Nums)),
    Result.