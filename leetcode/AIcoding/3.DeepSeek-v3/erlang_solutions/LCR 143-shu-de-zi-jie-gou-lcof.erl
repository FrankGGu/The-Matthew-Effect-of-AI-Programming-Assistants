-spec is_sub_structure(A :: #tree_node{} | null, B :: #tree_node{} | null) -> boolean().
is_sub_structure(null, _B) -> false;
is_sub_structure(_A, null) -> false;
is_sub_structure(A, B) ->
    check(A, B) orelse is_sub_structure(A#tree_node.left, B) orelse is_sub_structure(A#tree_node.right, B).

check(_A, null) -> true;
check(null, _B) -> false;
check(A, B) ->
    (A#tree_node.val =:= B#tree_node.val) andalso check(A#tree_node.left, B#tree_node.left) andalso check(A#tree_node.right, B#tree_node.right).