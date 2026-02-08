-spec min_diff_in_bst(Root :: #tree_node{} | null) -> integer().
min_diff_in_bst(Root) ->
    InOrder = in_order(Root, []),
    lists:min([B - A || {A, B} <- lists:zip(InOrder, tl(InOrder))]).

in_order(null, Acc) -> Acc;
in_order(#tree_node{val = Val, left = Left, right = Right}, Acc) ->
    in_order(Left, [Val | in_order(Right, Acc)]).