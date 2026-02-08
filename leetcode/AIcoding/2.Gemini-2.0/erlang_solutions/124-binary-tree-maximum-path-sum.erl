-module(max_path_sum).
-export([maxPathSum/1]).

-record(tree, {val, left, right}).

maxPathSum(Root) ->
    {_, MaxSum} = maxPathSumHelper(Root, -infinity).
    MaxSum.

maxPathSumHelper(null, MaxSoFar) ->
    {0, MaxSoFar};
maxPathSumHelper(Node, MaxSoFar) ->
    #tree{val = Val, left = Left, right = Right} = Node,
    {LeftSingle, LeftMax} = maxPathSumHelper(Left, MaxSoFar),
    {RightSingle, RightMax} = maxPathSumHelper(Right, MaxSoFar),
    SinglePath := max(0, max(LeftSingle, RightSingle)) + Val,
    MaxPath := max(LeftMax, max(RightMax, LeftSingle + RightSingle + Val)),
    {SinglePath, max(MaxSoFar, MaxPath)}.

max(A, B) ->
    if A > B -> A;
       true -> B
    end.

-define(infinity, 1 bsl 63 - 1).