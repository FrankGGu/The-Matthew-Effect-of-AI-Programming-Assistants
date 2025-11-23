-spec preorder_traversal(Root :: #tree_node{} | null) -> [integer()].
preorder_traversal(null) -> [];
preorder_traversal(Root) ->
    preorder_traversal(Root, []).

preorder_traversal(null, Acc) -> Acc;
preorder_traversal(#tree_node{val = Val, left = Left, right = Right}, Acc) ->
    [Val | preorder_traversal(Left, preorder_traversal(Right, Acc))].