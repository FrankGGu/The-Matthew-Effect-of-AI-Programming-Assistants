-spec is_valid_bst(Root :: #tree_node{} | null) -> boolean().
is_valid_bst(Root) ->
    is_valid(Root, null, null).

is_valid(null, _, _) -> true;
is_valid(#tree_node{val = Val, left = Left, right = Right}, Min, Max) ->
    (Min == null orelse Val > Min) andalso
    (Max == null orelse Val < Max) andalso
    is_valid(Left, Min, Val) andalso
    is_valid(Right, Val, Max).