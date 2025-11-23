-module(solution).
-export([hasPathSum/2]).

-type tree_node() :: {integer(), tree_node() | nil, tree_node() | nil}.
-spec hasPathSum(Root :: tree_node() | nil, TargetSum :: integer()) -> boolean().
hasPathSum(nil, _TargetSum) ->
    false;
hasPathSum({Val, nil, nil}, TargetSum) ->
    Val == TargetSum;
hasPathSum({Val, Left, Right}, TargetSum) ->
    NewTargetSum = TargetSum - Val,
    hasPathSum(Left, NewTargetSum) orelse
    hasPathSum(Right, NewTargetSum).