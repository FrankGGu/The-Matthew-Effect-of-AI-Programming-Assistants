-spec kth_smallest(Root :: #tree_node{} | null, K :: integer()) -> integer().
kth_smallest(Root, K) ->
    {_, Result} = traverse(Root, K, {0, -1}),
    Result.

traverse(null, K, {Count, Result}) ->
    {Count, Result};
traverse(#tree_node{left = Left, val = Val}, K, {Count, Result}) ->
    {Count1, Result1} = traverse(Left, K, {Count, Result}),
    case Result1 of
        -1 ->
            NewCount = Count1 + 1,
            if
                NewCount =:= K ->
                    {NewCount, Val};
                true ->
                    traverse(Left, K, {NewCount, Result1})
            end;
        _ ->
            {Count1, Result1}
    end;
traverse(#tree_node{right = Right, val = Val}, K, {Count, Result}) ->
    {Count1, Result1} = traverse(Right, K, {Count, Result}),
    {Count1, Result1}.