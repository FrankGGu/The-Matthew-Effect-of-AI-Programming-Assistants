-spec is_symmetric(Root :: #tree_node{} | null) -> boolean().
is_symmetric(null) -> true;
is_symmetric(Root) -> 
    check(Root#tree_node.left, Root#tree_node.right).

check(null, null) -> true;
check(null, _) -> false;
check(_, null) -> false;
check(Left, Right) ->
    (Left#tree_node.val =:= Right#tree_node.val) andalso
    check(Left#tree_node.left, Right#tree_node.right) andalso
    check(Left#tree_node.right, Right#tree_node.left).