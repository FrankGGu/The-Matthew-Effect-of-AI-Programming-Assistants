-spec reverse_odd_levels(Root :: #tree_node{} | null) -> #tree_node{} | null.
reverse_odd_levels(Root) ->
    case Root of
        null -> null;
        _ -> reverse_odd_levels(Root, 0)
    end.

-spec reverse_odd_levels(Node :: #tree_node{} | null, Level :: integer()) -> #tree_node{} | null.
reverse_odd_levels(null, _) -> null;
reverse_odd_levels(Node, Level) ->
    case Level rem 2 of
        1 ->
            Left = reverse_odd_levels(Node#tree_node.right, Level + 1),
            Right = reverse_odd_levels(Node#tree_node.left, Level + 1),
            Node#tree_node{left = Left, right = Right};
        0 ->
            Left = reverse_odd_levels(Node#tree_node.left, Level + 1),
            Right = reverse_odd_levels(Node#tree_node.right, Level + 1),
            Node#tree_node{left = Left, right = Right}
    end.