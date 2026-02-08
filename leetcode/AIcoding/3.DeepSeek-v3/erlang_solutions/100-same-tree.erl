-spec is_same_tree(P :: #tree_node{} | null, Q :: #tree_node{} | null) -> boolean().
is_same_tree(null, null) -> true;
is_same_tree(null, _) -> false;
is_same_tree(_, null) -> false;
is_same_tree(P, Q) ->
    P#tree_node.val == Q#tree_node.val andalso
    is_same_tree(P#tree_node.left, Q#tree_node.left) andalso
    is_same_tree(P#tree_node.right, Q#tree_node.right).