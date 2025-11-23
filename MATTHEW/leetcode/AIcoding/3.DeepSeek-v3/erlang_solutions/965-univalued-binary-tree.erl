-spec is_unival_tree(Root :: #tree_node{} | null) -> boolean().
is_unival_tree(null) -> true;
is_unival_tree(Root) ->
    Val = Root#tree_node.val,
    check(Root, Val).

check(null, _) -> true;
check(Node, Val) ->
    Node#tree_node.val =:= Val andalso
    check(Node#tree_node.left, Val) andalso
    check(Node#tree_node.right, Val).