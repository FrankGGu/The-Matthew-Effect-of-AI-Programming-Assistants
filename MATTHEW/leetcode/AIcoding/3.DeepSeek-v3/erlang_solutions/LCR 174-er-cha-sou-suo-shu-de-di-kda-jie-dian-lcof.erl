-spec find_target_node(#tree_node{} | null, integer()) -> integer().
find_target_node(Root, K) ->
    {_, Result} = traverse(Root, K, {0, 0}),
    Result.

traverse(null, _, {Count, _}) ->
    {Count, 0};
traverse(#tree_node{val = Val, left = Left, right = Right}, K, {Count, _}) ->
    {Count1, Result1} = traverse(Left, K, {Count, 0}),
    NewCount = Count1 + 1,
    if
        NewCount =:= K ->
            {NewCount, Val};
        true ->
            {Count2, Result2} = traverse(Right, K, {NewCount, 0}),
            {Count2, Result2}
    end.