-module(binary_tree_pruning).
-export([pruneTree/1]).

-spec pruneTree(TreeNode()) -> TreeNode().
pruneTree(nil) ->
  nil;
pruneTree(TreeNode{val = Val, left = Left, right = Right}) ->
  NewLeft = pruneTree(Left),
  NewRight = pruneTree(Right),
  case Val == 0 and NewLeft == nil and NewRight == nil of
    true ->
      nil;
    false ->
      TreeNode{val = Val, left = NewLeft, right = NewRight}
  end.

-type TreeNode() :: nil | #{val := integer(), left := TreeNode(), right := TreeNode()}.