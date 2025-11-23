-spec sum_of_left_leaves(Root :: #tree_node{} | null) -> integer().
sum_of_left_leaves(null) -> 0;
sum_of_left_leaves(Root) -> 
    sum_left(Root, false).

sum_left(null, _) -> 0;
sum_left(#tree_node{left = null, right = null}, true) -> 
    #tree_node{val = Val} = #tree_node{}, Val;
sum_left(#tree_node{left = Left, right = Right, val = _Val}, IsLeft) ->
    sum_left(Left, true) + sum_left(Right, false).