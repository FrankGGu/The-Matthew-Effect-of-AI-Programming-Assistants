-module(path_sum_ii).
-export([path_sum/2]).

path_sum(Root, TargetSum) ->
  find_paths(Root, TargetSum, []).

find_paths(null, _, _) ->
  [];
find_paths(TreeNode, TargetSum, Path) ->
  Val = TreeNode#tree_node.val,
  NewTarget = TargetSum - Val,
  NewPath = [Val | Path],
  if TreeNode#tree_node.left == null and TreeNode#tree_node.right == null ->
    if NewTarget == 0 ->
      [lists:reverse(NewPath)]
    else
      []
    end;
  true ->
    LeftPaths = find_paths(TreeNode#tree_node.left, NewTarget, NewPath),
    RightPaths = find_paths(TreeNode#tree_node.right, NewTarget, NewPath),
    LeftPaths ++ RightPaths
  end.