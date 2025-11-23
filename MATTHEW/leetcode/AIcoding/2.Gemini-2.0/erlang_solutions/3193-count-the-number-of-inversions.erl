-module(solution).
-export([count_inversions/1]).

count_inversions(Nums) ->
    count_inversions(Nums, 0).

count_inversions([], Count) ->
    Count;
count_inversions([_], Count) ->
    Count;
count_inversions(Nums, Count) ->
    {Left, Right} = lists:split(length(Nums) div 2, Nums),
    {LeftCount, LeftSorted} = merge_sort_and_count(Left, 0),
    {RightCount, RightSorted} = merge_sort_and_count(Right, 0),
    {MergeCount, Sorted} = merge_and_count(LeftSorted, RightSorted, 0),
    Count + LeftCount + RightCount + MergeCount.

merge_sort_and_count([], Count) ->
    {Count, []};
merge_sort_and_count([H], Count) ->
    {Count, [H]};
merge_sort_and_count(Nums, Count) ->
    {Left, Right} = lists:split(length(Nums) div 2, Nums),
    {LeftCount, LeftSorted} = merge_sort_and_count(Left, 0),
    {RightCount, RightSorted} = merge_sort_and_count(Right, 0),
    {MergeCount, Sorted} = merge_and_count(LeftSorted, RightSorted, 0),
    {Count + LeftCount + RightCount + MergeCount, Sorted}.

merge_and_count([], [], Count) ->
    {Count, []};
merge_and_count([], Right, Count) ->
    {Count, Right};
merge_and_count(Left, [], Count) ->
    {Count, Left};
merge_and_count([LHead | LTail], [RHead | RTail], Count) ->
    if LHead =< RHead ->
        {MergeCount, Rest} = merge_and_count(LTail, [RHead | RTail], Count);
        {MergeCount, [LHead | Rest]}
    else
        {MergeCount, Rest} = merge_and_count([LHead | LTail], RTail, Count + 1);
        {MergeCount + length([LHead | LTail]) - 1, [RHead | Rest]}
    end.