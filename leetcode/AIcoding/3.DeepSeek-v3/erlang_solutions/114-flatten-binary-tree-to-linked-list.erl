-spec flatten(Root :: #tree_node{} | null) -> ok.
flatten(null) -> ok;
flatten(Root) ->
    flatten_helper(Root),
    ok.

flatten_helper(#tree_node{left = null, right = Right} = Node) ->
    case Right of
        null -> Node;
        _ -> flatten_helper(Right)
    end;
flatten_helper(#tree_node{left = Left, right = Right} = Node) ->
    Last = flatten_helper(Left),
    OldRight = Node#tree_node.right,
    Node#tree_node.right = Node#tree_node.left,
    Node#tree_node.left = null,
    Last#tree_node.right = OldRight,
    case OldRight of
        null -> Last;
        _ -> flatten_helper(OldRight)
    end.