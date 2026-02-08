-module(path_sum).
-export([hasPathSum/2]).

-spec hasPathSum(TreeNode(), integer()) -> boolean().
hasPathSum(nil, _) -> false;
hasPathSum(TreeNode, TargetSum) ->
  Value = TreeNode#tree_node.val,
  Left = TreeNode#tree_node.left,
  Right = TreeNode#tree_node.right,
  NewTarget = TargetSum - Value,
  case {Left, Right} of
    {nil, nil} -> NewTarget =:= 0;
    {nil, _} -> hasPathSum(Right, NewTarget);
    {_, nil} -> hasPathSum(Left, NewTarget);
    {_, _} -> hasPathSum(Left, NewTarget) orelse hasPathSum(Right, NewTarget)
  end.

-record(tree_node, {val, left, right}).