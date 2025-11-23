-module(solution).
-export([postorderTraversal/1]).

-spec postorderTraversal(TreeNode()) -> [integer()].
postorderTraversal(null) ->
  [];
postorderTraversal(TreeNode) ->
  postorderTraversal(TreeNode#tree_node.left) ++
  postorderTraversal(TreeNode#tree_node.right) ++
  [TreeNode#tree_node.val].

-type TreeNode() :: null | #'tree_node'{val :: integer(), left :: TreeNode(), right :: TreeNode()}.

-record(tree_node, {val, left, right}).