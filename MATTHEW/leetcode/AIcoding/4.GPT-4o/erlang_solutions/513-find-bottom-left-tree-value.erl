%% Definition for a binary tree node.
%% -record(tree_node, {val = 0 :: integer(),
%%                     left = null  :: 'null' | #tree_node{},
%%                     right = null :: 'null' | #tree_node{}}).

%% Find the bottom left value of a binary tree.
-spec find_bottom_left_value(Root :: #tree_node{} | null) -> integer().
find_bottom_left_value(Root) ->
    find_bottom_left_value(Root, []).

%% Helper function to traverse the tree using BFS and find the bottom left value.
-spec find_bottom_left_value(#tree_node{} | null, [integer()]) -> integer().
find_bottom_left_value(null, _) -> 0;
find_bottom_left_value(#tree_node{left = null, right = null, val = Val}, []) -> Val;
find_bottom_left_value(#tree_node{left = null, right = Right, val = Val}, Level) ->
    find_bottom_left_value(Right, [Val | Level]);
find_bottom_left_value(#tree_node{left = Left, right = null, val = Val}, Level) ->
    find_bottom_left_value(Left, [Val | Level]);
find_bottom_left_value(#tree_node{left = Left, right = Right, val = Val}, Level) ->
    find_bottom_left_value(Left, [Val | Level]).
