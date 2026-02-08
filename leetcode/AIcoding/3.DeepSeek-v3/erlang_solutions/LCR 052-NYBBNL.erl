-spec increasing_bst(Root :: #tree_node{} | null) -> #tree_node{} | null.
increasing_bst(Root) ->
    {NewRoot, _} = helper(Root, null),
    NewRoot.

helper(null, Tail) ->
    {Tail, Tail};
helper(Node, Tail) ->
    {NewRoot, LeftTail} = helper(Node#tree_node.left, Tail),
    Node1 = Node#tree_node{left = null},
    LeftTail1 = 
        case LeftTail of
            null -> Node1;
            _ -> LeftTail#tree_node{right = Node1}
        end,
    helper(Node#tree_node.right, Node1).