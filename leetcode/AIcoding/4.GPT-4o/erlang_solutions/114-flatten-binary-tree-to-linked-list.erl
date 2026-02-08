%% Definition for binary tree node.
%% -record(tree_node, {val = 0 :: integer(), left = null :: 'null' | #tree_node{}, right = null :: 'null' | #tree_node{}}).

-spec flatten(Root :: #tree_node{} | null) -> void.
flatten(Root) ->
    flatten(Root, null).

flatten(null, _) -> ok;
flatten(#tree_node{left = Left, right = Right, val = Val}, Next) ->
    flatten(Left, Right),
    LeftNext = #tree_node{val = Val, left = null, right = Next},
    flatten(Left, LeftNext).

flatten(Head, Next) -> Head.
