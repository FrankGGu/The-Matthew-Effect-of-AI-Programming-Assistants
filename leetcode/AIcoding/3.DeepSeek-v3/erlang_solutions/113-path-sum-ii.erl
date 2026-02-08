-spec path_sum(Root :: #tree_node{} | null, TargetSum :: integer()) -> [[integer()]].
path_sum(null, _) -> [];
path_sum(Root, TargetSum) ->
    dfs(Root, TargetSum, [], []).

dfs(null, _, _, Acc) -> Acc;
dfs(#tree_node{val = Val, left = null, right = null}, TargetSum, Path, Acc) ->
    case TargetSum - Val of
        0 -> [lists:reverse([Val | Path]) | Acc];
        _ -> Acc
    end;
dfs(#tree_node{val = Val, left = Left, right = Right}, TargetSum, Path, Acc) ->
    NewPath = [Val | Path],
    NewTarget = TargetSum - Val,
    Acc1 = dfs(Left, NewTarget, NewPath, Acc),
    dfs(Right, NewTarget, NewPath, Acc1).