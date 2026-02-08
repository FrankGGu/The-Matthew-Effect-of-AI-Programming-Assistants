%% Definition for a binary tree node.
%% -record(tree_node, {val = 0 :: integer(),
%%                     left = null  :: 'null' | #tree_node{},
%%                     right = null :: 'null' | #tree_node{}}).

-spec count_nodes(Root :: #tree_node{} | null) -> integer().
count_nodes(null) -> 0;
count_nodes(#tree_node{left = Left, right = Right}) ->
    1 + count_nodes(Left) + count_nodes(Right).
