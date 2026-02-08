-spec find_bottom_left_value(Root :: #tree_node{} | null) -> integer().
find_bottom_left_value(Root) ->
    case Root of
        null -> 0;
        _ ->
            {Val, _} = traverse(Root, 0, 0, Root#tree_node.val),
            Val
    end.

traverse(Node, Depth, MaxDepth, LeftVal) when Node =:= null ->
    {LeftVal, MaxDepth};
traverse(Node, Depth, MaxDepth, LeftVal) ->
    {LeftVal1, MaxDepth1} = traverse(Node#tree_node.left, Depth + 1, MaxDepth, LeftVal),
    {LeftVal2, MaxDepth2} = traverse(Node#tree_node.right, Depth + 1, MaxDepth1, LeftVal1),
    if
        Depth > MaxDepth2 -> {Node#tree_node.val, Depth};
        true -> {LeftVal2, MaxDepth2}
    end.