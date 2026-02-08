-module(solution).
-export([solve/1]).

dfs(nil) ->
    {0, 0}; %% Base case: An empty tree has a subtree sum of 0 and an inversion sum of 0.
dfs({Val, Left, Right}) ->
    %% Recursively calculate for left and right children
    {LeftSubtreeSum, LeftTotalInversionSum} = dfs(Left),
    {RightSubtreeSum, RightTotalInversionSum} = dfs(Right),

    %% Calculate the subtree sum for the current node
    CurrentSubtreeSum = Val + LeftSubtreeSum + RightSubtreeSum,

    %% Calculate the "inversion sum" for the current node
    CurrentNodeInversionSum = Val - (LeftSubtreeSum + RightSubtreeSum),

    %% Accumulate the total inversion sum for the current subtree
    TotalInversionSum = CurrentNodeInversionSum + LeftTotalInversionSum + RightTotalInversionSum,

    {CurrentSubtreeSum, TotalInversionSum}.

solve(Root) ->
    {_SubtreeSumOfRoot, TotalInversionSum} = dfs(Root),
    TotalInversionSum.