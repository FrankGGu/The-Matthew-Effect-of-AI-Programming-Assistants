-module(solution).
-export([reverse_pairs/1]).

reverse_pairs(Numbers) ->
    {Count, _} = merge_sort(Numbers),
    Count.

merge_sort([]) -> {0, []};
merge_sort([X]) -> {0, [X]};
merge_sort(List) ->
    {Left, Right} = lists:split(length(List) div 2),
    {CountLeft, SortedLeft} = merge_sort(Left),
    {CountRight, SortedRight} = merge_sort(Right),
    {CountMerge, Merged} = merge(SortedLeft, SortedRight),
    {CountLeft + CountRight + CountMerge, Merged}.

merge([], Right) -> {0, Right};
merge(Left, []) -> {0, Left};
merge([LHead | LTail] = Left, [RHead | RTail] = Right) ->
    case LHead > RHead of
        true ->
            {Count, Merged} = merge(Left, RTail),
            {Count + length(Left), [RHead | Merged]};
        false ->
            {Count, Merged} = merge(LTail, Right),
            {Count, [LHead | Merged]}
    end.