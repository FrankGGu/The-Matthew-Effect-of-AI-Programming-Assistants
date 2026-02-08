-module(solution).
-export([average_of_subtree/1]).

-include("leetcode.hrl").

average_of_subtree(Root) ->
    {_, Count} = dfs(Root),
    Count.

dfs(nil) ->
    {0, 0};
dfs(#TreeNode{val = Val, left = Left, right = Right}) ->
    {LeftSum, LeftCount} = dfs(Left),
    {RightSum, RightCount} = dfs(Right),
    TotalSum = Val + LeftSum + RightSum,
    TotalCount = 1 + LeftCount + RightCount,
    CurrentAvg = TotalSum div TotalCount,
    if
        Val == CurrentAvg ->
            {TotalSum, 1 + LeftCount + RightCount};
        true ->
            {TotalSum, LeftCount + RightCount}
    end.