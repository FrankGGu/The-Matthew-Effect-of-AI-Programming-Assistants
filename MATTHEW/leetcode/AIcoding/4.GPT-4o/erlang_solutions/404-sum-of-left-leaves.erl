-module(solution).
-export([sum_of_left_leaves/1]).

-record(tree_node, {val, left = null, right = null}).

%% Function to calculate the sum of all left leaves.
-spec sum_of_left_leaves(#tree_node{} | null) -> integer().
sum_of_left_leaves(null) -> 0;
sum_of_left_leaves(#tree_node{left = null, right = null}) -> 0; %% No left leaf if node has no children
sum_of_left_leaves(#tree_node{left = #tree_node{left = null, right = null}, right = _}) -> %% Left child is a leaf
    LeftVal = 1; %% Left child is a leaf with value
    LeftVal
;
sum_of_left_leaves(#tree_node{left = Left, right = Right}) -> %% Traverse both subtrees
    LeftSum = sum_of_left_leaves(Left),
    RightSum = sum_of_left_leaves(Right),
    LeftSum + RightSum.
