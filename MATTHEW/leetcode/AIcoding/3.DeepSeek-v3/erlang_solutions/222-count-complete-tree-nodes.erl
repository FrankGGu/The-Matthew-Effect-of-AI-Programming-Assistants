-spec count_nodes(Root :: #tree_node{} | null) -> integer().
count_nodes(null) -> 0;
count_nodes(Root) ->
    LeftHeight = left_height(Root),
    RightHeight = right_height(Root),
    case LeftHeight =:= RightHeight of
        true -> (1 bsl LeftHeight) - 1;
        false -> 1 + count_nodes(Root#tree_node.left) + count_nodes(Root#tree_node.right)
    end.

left_height(null) -> 0;
left_height(Node) -> 1 + left_height(Node#tree_node.left).

right_height(null) -> 0;
right_height(Node) -> 1 + right_height(Node#tree_node.right).