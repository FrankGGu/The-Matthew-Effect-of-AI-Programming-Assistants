-module(solution).
-export([pathSum/2]).

-record(node, {val, left = nil, right = nil}).

pathSum(Tree, TargetSum) ->
    pathSum(Tree, TargetSum, 0).

pathSum(nil, _, _) -> 0;
pathSum(Node, TargetSum, CurrentSum) ->
    NewSum = CurrentSum + Node#node.val,
    NewCount = if NewSum == TargetSum -> 1; true -> 0 end,
    NewCount + pathSum(Node#node.left, TargetSum, NewSum) + pathSum(Node#node.right, TargetSum, NewSum).