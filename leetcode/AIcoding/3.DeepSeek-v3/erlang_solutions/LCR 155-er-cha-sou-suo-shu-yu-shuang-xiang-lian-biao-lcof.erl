-record(tree_node, {val = 0 :: integer(),
                   left = null  :: 'null' | #tree_node{},
                   right = null :: 'null' | #tree_node{}}).

-spec tree_to_doubly_list(Root :: #tree_node{} | null) -> #tree_node{} | null.
tree_to_doubly_list(null) -> null;
tree_to_doubly_list(Root) ->
    {First, Last} = in_order_traversal(Root, null, null),
    First#tree_node{left = Last, right = Last},
    Last#tree_node{left = First, right = First},
    First.

in_order_traversal(null, Prev, First) -> {First, Prev};
in_order_traversal(Node, Prev, First) ->
    {NewFirst, LeftPrev} = in_order_traversal(Node#tree_node.left, Prev, First),
    CurrentFirst = case NewFirst of null -> Node; _ -> NewFirst end,
    Node#tree_node.left = LeftPrev,
    case LeftPrev of
        null -> ok;
        _ -> LeftPrev#tree_node.right = Node
    end,
    in_order_traversal(Node#tree_node.right, Node, CurrentFirst).