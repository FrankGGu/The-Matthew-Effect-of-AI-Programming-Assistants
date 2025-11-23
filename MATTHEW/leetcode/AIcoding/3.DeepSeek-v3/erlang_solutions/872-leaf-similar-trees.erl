-spec leaf_similar(Root1 :: #tree_node{} | null, Root2 :: #tree_node{} | null) -> boolean().
leaf_similar(Root1, Root2) ->
    Leaves1 = get_leaves(Root1, []),
    Leaves2 = get_leaves(Root2, []),
    Leaves1 =:= Leaves2.

get_leaves(null, Acc) -> Acc;
get_leaves(#tree_node{left = null, right = null, val = Val}, Acc) ->
    [Val | Acc];
get_leaves(#tree_node{left = Left, right = Right}, Acc) ->
    NewAcc = get_leaves(Right, Acc),
    get_leaves(Left, NewAcc).