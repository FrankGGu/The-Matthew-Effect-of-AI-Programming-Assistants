-spec get_all_elements(Root1 :: #tree_node{} | null, Root2 :: #tree_node{} | null) -> [integer()].
get_all_elements(Root1, Root2) ->
    List1 = inorder(Root1, []),
    List2 = inorder(Root2, []),
    merge(List1, List2).

inorder(null, Acc) -> Acc;
inorder(#tree_node{val = Val, left = Left, right = Right}, Acc) ->
    Acc1 = inorder(Left, Acc),
    Acc2 = [Val | Acc1],
    inorder(Right, Acc2).

merge([], List) -> lists:reverse(List);
merge(List, []) -> lists:reverse(List);
merge([X | Xs], [Y | Ys]) when X =< Y ->
    [X | merge(Xs, [Y | Ys])];
merge([X | Xs], [Y | Ys]) ->
    [Y | merge([X | Xs], Ys)].