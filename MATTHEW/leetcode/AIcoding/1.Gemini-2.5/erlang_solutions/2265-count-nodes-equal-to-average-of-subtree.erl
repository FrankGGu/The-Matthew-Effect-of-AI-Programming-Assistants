-module(solution).
-export([countNodesEqualtoAverageOfSubtree/1]).

-record('TreeNode', {val, left, right}).

countNodesEqualtoAverageOfSubtree(Root) ->
    {_Sum, _Count, MatchingNodes} = dfs(Root),
    MatchingNodes.

dfs(null) ->
    {0, 0, 0};
dfs(#'TreeNode'{val = Val, left = Left, right = Right}) ->
    {LeftSum, LeftCount, LeftMatching} = dfs(Left),
    {RightSum, RightCount, RightMatching} = dfs(Right),

    CurrentSum = Val + LeftSum + RightSum,
    CurrentCount = 1 + LeftCount + RightCount,

    Average = CurrentSum div CurrentCount,

    CurrentNodeMatches =
        if Val == Average ->
            1;
        true ->
            0
        end,

    {CurrentSum, CurrentCount, CurrentNodeMatches + LeftMatching + RightMatching}.