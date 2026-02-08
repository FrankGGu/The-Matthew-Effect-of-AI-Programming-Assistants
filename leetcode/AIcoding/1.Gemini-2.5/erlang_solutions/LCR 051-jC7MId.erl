-module(solution).
-export([max_path_sum/1]).

max_path_sum(Root) ->
    {_PathFromRoot, GlobalMax} = max_path_sum_helper(Root, -1000000001),
    GlobalMax.

max_path_sum_helper(nil, AccMax) ->
    {0, AccMax};
max_path_sum_helper({node, Val, Left, Right}, AccMax) ->
    {LeftPath, AccMax1} = max_path_sum_helper(Left, AccMax),
    {RightPath, AccMax2} = max_path_sum_helper(Right, AccMax1),

    LeftBranchSum = max(0, LeftPath),
    RightBranchSum = max(0, RightPath),

    CurrentPathSum = Val + LeftBranchSum + RightBranchSum,

    NewAccMax = max(AccMax2, CurrentPathSum),

    PathFromNode = Val + max(LeftBranchSum, RightBranchSum),

    {PathFromNode, NewAccMax}.