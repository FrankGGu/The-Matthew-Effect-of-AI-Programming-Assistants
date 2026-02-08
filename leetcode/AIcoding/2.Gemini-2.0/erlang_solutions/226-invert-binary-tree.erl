-module(invert_binary_tree).
-export([invertTree/1]).

-spec invertTree(TreeNode()) -> TreeNode().
invertTree(null) -> null;
invertTree(TreeNode) ->
  #TreeNode{val = Val, left = Left, right = Right} = TreeNode,
  InvertedLeft = invertTree(Right),
  InvertedRight = invertTree(Left),
  #TreeNode{val = Val, left = InvertedLeft, right = InvertedRight}.