-module(solution).
-export([increasing_bst/1]).

increasing_bst(Root) ->
    ValuesInOrder = lists:reverse(get_values_inorder(Root, [])),
    build_increasing_tree(ValuesInOrder).

get_values_inorder(nil, Acc) ->
    Acc;
get_values_inorder({Val, Left, Right}, Acc) ->
    Acc2 = get_values_inorder(Left, Acc),
    Acc3 = [Val | Acc2],
    get_values_inorder(Right, Acc3).

build_increasing_tree([]) ->
    nil;
build_increasing_tree([H | T]) ->
    build_increasing_tree_helper(H, T).

build_increasing_tree_helper(Val, []) ->
    {Val, nil, nil};
build_increasing_tree_helper(Val, [NextVal | Rest]) ->
    {Val, nil, build_increasing_tree_helper(NextVal, Rest)}.