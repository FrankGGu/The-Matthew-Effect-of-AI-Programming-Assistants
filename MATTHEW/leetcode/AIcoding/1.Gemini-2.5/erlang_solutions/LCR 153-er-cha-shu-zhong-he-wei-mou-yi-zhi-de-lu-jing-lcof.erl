-module(solution).
-export([hasPathSum/2]).

hasPathSum(nil, _TargetSum) ->
    false;
hasPathSum({Val, Left, Right}, TargetSum) ->
    NewTargetSum = TargetSum - Val,
    case {Left, Right} of
        {nil, nil} -> %% This is a leaf node
            NewTargetSum == 0;
        _ -> %% Not a leaf node, continue searching in children
            hasPathSum(Left, NewTargetSum) orelse hasPathSum(Right, NewTargetSum)
    end.