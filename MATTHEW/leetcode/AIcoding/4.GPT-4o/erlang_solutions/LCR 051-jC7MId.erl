-module(solution).
-export([maxPathSum/1]).

-record(node, {val, left = null, right = null}).

maxPathSum(Root) ->
    {MaxSum, _} = maxPathSumHelper(Root),
    MaxSum.

maxPathSumHelper(null) ->
    {0, 0};
maxPathSumHelper(#node{val=Val, left=Left, right=Right}) ->
    {LeftMax, LeftBest} = maxPathSumHelper(Left),
    {RightMax, RightBest} = maxPathSumHelper(Right),
    CurrentMax = max(0, LeftMax) + max(0, RightMax) + Val,
    BestCurrent = max(LeftBest, RightBest, CurrentMax),
    {max(0, max(LeftMax, RightMax) + Val), BestCurrent}.