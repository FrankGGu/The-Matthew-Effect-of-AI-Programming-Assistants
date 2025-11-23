-spec increasing_bst(Root :: #tree_node{} | null) -> #tree_node{} | null.
increasing_bst(Root) ->
    {NewRoot, _} = traverse(Root, null),
    NewRoot.

traverse(null, Prev) -> {Prev, Prev};
traverse(Node, Prev) ->
    {NewRoot, LeftPrev} = traverse(Node#tree_node.left, Prev),
    Current = #tree_node{val = Node#tree_node.val, left = null},
    case LeftPrev of
        null -> ok;
        _ -> LeftPrev#tree_node.right = Current
    end,
    {RightRoot, RightPrev} = traverse(Node#tree_node.right, Current),
    case NewRoot of
        null -> {Current, RightPrev};
        _ -> {NewRoot, RightPrev}
    end.