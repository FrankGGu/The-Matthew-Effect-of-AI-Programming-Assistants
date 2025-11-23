%% Definition for a binary tree node.
%% -record(tree_node, {val = 0 :: integer(),
%%                     left = null  :: 'null' | #tree_node{},
%%                     right = null :: 'null' | #tree_node{}}).

-spec min_depth(Root :: #tree_node{} | null) -> integer().
min_depth(null) -> 0;
min_depth(#tree_node{left = null, right = null}) -> 1;
min_depth(#tree_node{left = Left, right = null}) -> min_depth(Left) + 1;
min_depth(#tree_node{left = null, right = Right}) -> min_depth(Right) + 1;
min_depth(#tree_node{left = Left, right = Right}) ->
    MinLeft = min_depth(Left),
    MinRight = min_depth(Right),
    1 + min(MinLeft, MinRight).
