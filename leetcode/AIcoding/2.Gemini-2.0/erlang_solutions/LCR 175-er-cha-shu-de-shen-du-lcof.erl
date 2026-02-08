-module(btree_depth).
-export([maxDepth/1]).

maxDepth(null) ->
  0;
maxDepth(TreeNode) ->
  max(maxDepth(TreeNode#tree_node.left), maxDepth(TreeNode#tree_node.right)) + 1.

-record(tree_node, {val, left, right}).