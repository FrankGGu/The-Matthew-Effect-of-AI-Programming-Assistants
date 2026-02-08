-module(max_path_sum).
-export([maxPathSum/1]).

maxPathSum(Root) ->
  {_, MaxSum} = maxPathSumHelper(Root, -1001).
  MaxSum.

maxPathSumHelper(null, MaxSum) ->
  {0, MaxSum};
maxPathSumHelper({Val, Left, Right}, MaxSum) ->
  {LeftSum, LeftMax} = maxPathSumHelper(Left, MaxSum),
  {RightSum, RightMax} = maxPathSumHelper(Right, MaxSum),
  SinglePathSum = Val + max(0, max(LeftSum, RightSum)),
  MaxPathSum = max(LeftMax, max(RightMax, max(MaxSum, Val + max(0, LeftSum) + max(0, RightSum)))),
  {SinglePathSum, MaxPathSum}.

max(A, B) ->
  if A > B -> A;
  true -> B
  end.