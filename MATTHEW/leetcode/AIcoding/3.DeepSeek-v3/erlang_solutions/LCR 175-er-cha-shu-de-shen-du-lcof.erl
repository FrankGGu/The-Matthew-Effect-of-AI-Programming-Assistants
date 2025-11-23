-spec max_depth(Root :: #tree_node{} | null) -> integer().
max_depth(null) -> 0;
max_depth(#tree_node{left = Left, right = Right}) ->
    1 + max(max_depth(Left), max_depth(Right)).