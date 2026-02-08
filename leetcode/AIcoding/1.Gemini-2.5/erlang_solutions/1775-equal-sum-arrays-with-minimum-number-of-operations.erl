-module(solution).
-export([min_operations/2]).

min_operations(Nums1, Nums2) ->
    L1 = length(Nums1),
    L2 = length(Nums2),

    if L1 > 6 * L2 orelse L2 > 6 * L1 ->
        -1;
    true ->
        Sum1 = lists:sum(Nums1),
        Sum2 = lists:sum(Nums2),

        if Sum1 == Sum2 ->
            0;
        true ->
            {SmallerSum, LargerSum, SmallerSumNums, LargerSumNums} =
                if Sum1 < Sum2 -> {Sum1, Sum2, Nums1, Nums2};
                   true -> {Sum2, Sum1, Nums2, Nums1}
                end,

            Diff = LargerSum - SmallerSum,

            GainsFromSmaller = [6 - X || X <- SmallerSumNums],
            GainsFromLarger = [X - 1 || X <- LargerSumNums],

            AllGains = lists:sort(fun(A, B) -> A >= B end, GainsFromSmaller ++ GainsFromLarger),

            count_operations(Diff, AllGains, 0)
        end
    end.

count_operations(Diff, _AllGains, Ops) when Diff =< 0 ->
    Ops;
count_operations(Diff, [Gain | RestGains], Ops) ->
    count_operations(Diff - Gain, RestGains, Ops + 1).