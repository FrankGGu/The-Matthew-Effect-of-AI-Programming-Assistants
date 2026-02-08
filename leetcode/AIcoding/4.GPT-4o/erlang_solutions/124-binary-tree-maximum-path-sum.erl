%% Definition for a binary tree node.
%% -record(tree_node, {val = 0 :: integer(),
%%                     left = null  :: 'null' | #tree_node{},
%%                     right = null :: 'null' | #tree_node{}}).

-spec max_path_sum(Root :: #tree_node{} | null) -> integer().
max_path_sum(Root) ->
    max_path_sum(Root, -infinity).

-spec max_path_sum(Root :: #tree_node{} | null, Max :: integer()) -> integer().
max_path_sum(null, Max) -> Max;
max_path_sum(#tree_node{val = Val, left = Left, right = Right}, Max) ->
    LeftMax = max_path_sum(Left, Max),
    RightMax = max_path_sum(Right, Max),
    MaxLeft = max(0, LeftMax),
    MaxRight = max(0, RightMax),
    max(Max, Val + MaxLeft + MaxRight).
