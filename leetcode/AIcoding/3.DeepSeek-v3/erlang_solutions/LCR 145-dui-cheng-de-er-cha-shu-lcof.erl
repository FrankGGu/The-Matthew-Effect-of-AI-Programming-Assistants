-spec is_symmetric(Root :: #tree_node{} | null) -> boolean().
is_symmetric(null) -> true;
is_symmetric(Root) -> 
    is_mirror(Root#tree_node.left, Root#tree_node.right).

is_mirror(null, null) -> true;
is_mirror(null, _) -> false;
is_mirror(_, null) -> false;
is_mirror(Left, Right) ->
    (Left#tree_node.val =:= Right#tree_node.val) andalso
    is_mirror(Left#tree_node.left, Right#tree_node.right) andalso
    is_mirror(Left#tree_node.right, Right#tree_node.left).