%% Definition for a binary tree node.
%% -record(tree_node, {val = 0 :: integer(),
%%                     left = null  :: 'null' | #tree_node{},
%%                     right = null :: 'null' | #tree_node{}}).

-spec has_path_sum(Root :: #tree_node{} | null, TargetSum :: integer()) -> boolean().
has_path_sum(null, _) -> false;
has_path_sum(#tree_node{val = Val, left = null, right = null}, TargetSum) when Val =:= TargetSum -> true;
has_path_sum(#tree_node{val = Val, left = Left, right = Right}, TargetSum) ->
    NewTargetSum = TargetSum - Val,
    has_path_sum(Left, NewTargetSum) orelse has_path_sum(Right, NewTargetSum).
