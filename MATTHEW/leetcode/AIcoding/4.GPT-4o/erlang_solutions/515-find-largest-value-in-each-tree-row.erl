%% Define the tree node structure.
%% -record(tree_node, {val = 0 :: integer(), left = null :: 'null' | #tree_node{}, right = null :: 'null' | #tree_node{}}).

-spec largest_values(Root :: #tree_node{} | null) -> [integer()].
largest_values(Root) ->
    largest_values_helper([Root], []).

-spec largest_values_helper(Nodes :: [#tree_node{} | null], Acc :: [integer()]) -> [integer()].
largest_values_helper([], Acc) -> lists:reverse(Acc);
largest_values_helper([null | Rest], Acc) -> largest_values_helper(Rest, Acc);
largest_values_helper([Node | Rest], Acc) ->
    largest_values_helper(Rest, [max_node_value(Node) | Acc]).

%% Find the maximum value in the current level.
-spec max_node_value(Node :: #tree_node{}) -> integer().
max_node_value(Node) ->
    max_node_value(Node, -infinity).

-spec max_node_value(Node :: #tree_node{}, MaxVal :: integer()) -> integer().
max_node_value(null, MaxVal) -> MaxVal;
max_node_value(#tree_node{val = Val, left = Left, right = Right}, MaxVal) ->
    NewMax = max(MaxVal, Val),
    MaxLeft = max_node_value(Left, NewMax),
    max_node_value(Right, MaxLeft).

%% Example call:
%% largest_values(#tree_node{val = 1, left = #tree_node{val = 3, left = #tree_node{val = 5}, right = #tree_node{val = 3}}, right = #tree_node{val = 2, right = #tree_node{val = 9}}}).
