-spec count_inversions(Nums :: [integer()]) -> integer().
count_inversions(Nums) ->
    {Count, _} = merge_sort(Nums),
    Count.

merge_sort(List) ->
    case List of
        [] -> {0, []};
        [X] -> {0, [X]};
        _ ->
            {Left, Right} = lists:split(length(List) div 2, List),
            {LeftCount, SortedLeft} = merge_sort(Left),
            {RightCount, SortedRight} = merge_sort(Right),
            {MergeCount, Merged} = merge(SortedLeft, SortedRight),
            {LeftCount + RightCount + MergeCount, Merged}
    end.

merge(Left, Right) ->
    merge(Left, Right, 0, []).

merge([], Right, Count, Acc) ->
    {Count, Acc ++ Right};
merge(Left, [], Count, Acc) ->
    {Count, Acc ++ Left};
merge([X | LeftTail], [Y | RightTail] = Right, Count, Acc) when X =< Y ->
    merge(LeftTail, Right, Count, Acc ++ [X]);
merge([X | LeftTail] = Left, [Y | RightTail], Count, Acc) ->
    merge(Left, RightTail, Count + length(Left), Acc ++ [Y]).