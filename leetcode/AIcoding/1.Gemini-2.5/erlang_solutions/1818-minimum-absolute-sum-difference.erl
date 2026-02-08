-module(solution).
-export([min_absolute_sum_diff/2]).

min_absolute_sum_diff(Nums1, Nums2) ->
    PairedLists = lists:zip(Nums1, Nums2),

    {InitialSumDiff, Tree} = lists:foldl(
        fun({N1_i, N2_i}, {AccDiff, AccTree}) ->
            {AccDiff + abs(N1_i - N2_i), gb_trees:insert(N1_i, true, AccTree)}
        end,
        {0, gb_trees:empty()},
        PairedLists
    ),

    MaxSaving = lists:foldl(
        fun({N1_i, N2_i}, CurrentMaxSaving) ->
            CurrentDiff = abs(N1_i - N2_i),

            MinPossibleDiff = find_min_diff_in_tree(N2_i, Tree),

            Saving = CurrentDiff - MinPossibleDiff,
            max(CurrentMaxSaving, Saving)
        end,
        0,
        PairedLists
    ),

    InitialSumDiff - MaxSaving.

find_min_diff_in_tree(Target, Tree) ->
    LE_Result = gb_trees:lookup_le(Target, Tree),
    GE_Result = gb_trees:lookup_ge(Target, Tree),

    case {LE_Result, GE_Result} of
        {{value, LE_Val, _}, {value, GE_Val, _}} ->
            min(abs(Target - LE_Val), abs(Target - GE_Val));
        {{value, LE_Val, _}, none} ->
            abs(Target - LE_Val);
        {none, {value, GE_Val, _}} ->
            abs(Target - GE_Val);
        {none, none} ->
            0
    end.