-module(min_squared_difference).
-export([min_sum_square_diff/3]).

min_sum_square_diff(Nums1, Nums2, K1) ->
    Diffs = lists:map(fun(X, Y) -> abs(X - Y) end, Nums1, Nums2),
    K = K1,
    SortedDiffs = lists:sort(Diffs, fun(A, B) -> A > B end),
    {FinalSortedDiffs, FinalK} = adjust_diffs(SortedDiffs, K),

    lists:foldl(fun(Diff, Acc) -> Acc + Diff * Diff end, 0, FinalSortedDiffs).

adjust_diffs(SortedDiffs, K) ->
    adjust_diffs_helper(SortedDiffs, K, []).

adjust_diffs_helper([], K, Acc) ->
    {lists:reverse(Acc), K};
adjust_diffs_helper([Diff | Rest], 0, Acc) ->
    {lists:reverse([Diff | Acc]), 0};
adjust_diffs_helper([Diff | Rest], K, Acc) ->
    if
        Diff > 0 ->
            adjust_diffs_helper(Rest, K - 1, [Diff - 1 | Acc]);
        true ->
            adjust_diffs_helper(Rest, K, [Diff | Acc])
    end.