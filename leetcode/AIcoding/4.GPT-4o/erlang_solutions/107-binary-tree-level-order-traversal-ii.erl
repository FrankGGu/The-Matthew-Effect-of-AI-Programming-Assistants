%% Definition for a binary tree node.
%% -record(tree_node, {val = 0 :: integer(),
%%                     left = null  :: 'null' | #tree_node{},
%%                     right = null :: 'null' | #tree_node{}}).

-spec level_order_bottom(Root :: #tree_node{} | null) -> [[integer()]].
level_order_bottom(Root) ->
    level_order_bottom([Root], []).

level_order_bottom([], Acc) -> lists:reverse(Acc);
level_order_bottom([null | Tail], Acc) -> level_order_bottom(Tail, Acc);
level_order_bottom([#tree_node{left = Left, right = Right, val = Val} | Tail], Acc) ->
    level_order_bottom(Tail ++ lists:filtermap(fun(X) -> case X of null -> []; _ -> [X] end end, [Left, Right]), [[Val] | Acc]).
