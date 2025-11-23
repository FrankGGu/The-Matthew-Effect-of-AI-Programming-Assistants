-module(solution).
-export([increasing_bst/1]).

increasing_bst(Root) ->
    Values = inorder_iterative(Root),
    build_right_skewed_tree(Values).

inorder_iterative(Root) ->
    inorder_iterative(Root, [], []).

inorder_iterative(nil, [], Acc) ->
    lists:reverse(Acc);

inorder_iterative(nil, [Node | Stack], Acc) ->
    {node, Val, _Left, Right} = Node,
    inorder_iterative(Right, Stack, [Val | Acc]);

inorder_iterative({node, _Val, Left, _Right} = Node, Stack, Acc) ->
    inorder_iterative(Left, [Node | Stack], Acc).

build_right_skewed_tree([]) ->
    nil;
build_right_skewed_tree([Val | Rest]) ->
    {node, Val, nil, build_right_skewed_tree(Rest)}.