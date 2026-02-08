-spec has_path_sum(Root :: #tree_node{} | null, TargetSum :: integer()) -> boolean().
has_path_sum(null, _TargetSum) -> false;
has_path_sum(#tree_node{val = Val, left = null, right = null}, TargetSum) -> 
    TargetSum =:= Val;
has_path_sum(#tree_node{val = Val, left = Left, right = Right}, TargetSum) ->
    NewTarget = TargetSum - Val,
    has_path_sum(Left, NewTarget) orelse has_path_sum(Right, NewTarget).