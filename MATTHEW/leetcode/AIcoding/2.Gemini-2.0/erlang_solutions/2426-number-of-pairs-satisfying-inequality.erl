-module(number_of_pairs).
-export([number_of_pairs/3]).

number_of_pairs(Nums1, Nums2, Diff) ->
    Diffs = [N1 - N2 || {N1, N2} <- lists:zip(Nums1, Nums2)],
    merge_sort_and_count(Diffs, Diff).

merge_sort_and_count(List, Diff) ->
    merge_sort_and_count(List, Diff, 0).

merge_sort_and_count([], _Diff, Count) ->
    Count;
merge_sort_and_count([H], _Diff, Count) ->
    Count;
merge_sort_and_count(List, Diff, Count) ->
    {Left, Right} = lists:split(length(List) div 2, List),
    merge_sort_and_count(Left, Diff, Count1) ->
        SortedLeft = merge_sort(Left),
        merge_sort_and_count(Right, Diff, Count2) ->
            SortedRight = merge_sort(Right),
            {Merged, NewCount} = merge_and_count(SortedLeft, SortedRight, Diff, Count1 + Count2),
            NewCount.

merge_sort([]) ->
    [];
merge_sort([H]) ->
    [H];
merge_sort(List) ->
    {Left, Right} = lists:split(length(List) div 2, List),
    merge(merge_sort(Left), merge_sort(Right)).

merge([], Right) ->
    Right;
merge(Left, []) ->
    Left;
merge([LHead | LTail], [RHead | RTail]) ->
    if LHead =< RHead ->
        [LHead | merge(LTail, [RHead | RTail])];
    true ->
        [RHead | merge([LHead | LTail], RTail)]
    end.

merge_and_count(Left, Right, Diff, Count) ->
    merge_and_count(Left, Right, Diff, Count, [], 0).

merge_and_count([], Right, _Diff, Count, Acc, NewCount) ->
    {lists:reverse(Acc) ++ Right, Count + NewCount};
merge_and_count(Left, [], _Diff, Count, Acc, NewCount) ->
    {lists:reverse(Acc) ++ Left, Count + NewCount};
merge_and_count([LHead | LTail], [RHead | RTail], Diff, Count, Acc, NewCount) ->
    if LHead =< RHead + Diff ->
        merge_and_count(LTail, [RHead | RTail], Diff, Count, [LHead | Acc], NewCount + length([RHead | RTail]));
    true ->
        merge_and_count([LHead | LTail], RTail, Diff, Count, [RHead | Acc], NewCount)
    end.