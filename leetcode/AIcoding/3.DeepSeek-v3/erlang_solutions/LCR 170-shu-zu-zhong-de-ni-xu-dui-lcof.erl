-spec reverse_pairs(Nums :: [integer()]) -> integer().
reverse_pairs(Nums) ->
    {Count, _} = merge_sort(Nums),
    Count.

merge_sort(List) ->
    case List of
        [] -> {0, []};
        [X] -> {0, [X]};
        _ ->
            {Left, Right} = lists:split(length(List) div 2, List),
            {CountLeft, SortedLeft} = merge_sort(Left),
            {CountRight, SortedRight} = merge_sort(Right),
            {CountMerge, Merged} = merge(SortedLeft, SortedRight),
            {CountLeft + CountRight + CountMerge, Merged}
    end.

merge(Left, Right) ->
    merge(Left, Right, 0, []).

merge([], Right, Count, Acc) ->
    {Count, lists:reverse(Acc) ++ Right};
merge(Left, [], Count, Acc) ->
    {Count, lists:reverse(Acc) ++ Left};
merge([X | LeftTail] = Left, [Y | RightTail] = Right, Count, Acc) ->
    if
        X > Y ->
            merge(Left, RightTail, Count + length(Left), [Y | Acc]);
        true ->
            merge(LeftTail, Right, Count, [X | Acc])
    end.