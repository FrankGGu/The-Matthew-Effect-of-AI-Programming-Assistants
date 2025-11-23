-spec postorder_traversal(Root :: #tree_node{} | null) -> [integer()].
postorder_traversal(null) -> [];
postorder_traversal(Root) ->
    postorder_traversal(Root, []).

postorder_traversal(null, Acc) -> Acc;
postorder_traversal(#tree_node{val = Val, left = Left, right = Right}, Acc) ->
    Acc1 = postorder_traversal(Left, Acc),
    Acc2 = postorder_traversal(Right, Acc1),
    [Val | Acc2].