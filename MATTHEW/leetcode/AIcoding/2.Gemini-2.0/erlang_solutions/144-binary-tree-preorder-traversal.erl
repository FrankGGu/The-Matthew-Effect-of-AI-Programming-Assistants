-module(preorder_traversal).
-export([preorderTraversal/1]).

-spec preorderTraversal(TreeNode()) -> [integer()].
preorderTraversal(Root) ->
  preorderTraversalHelper(Root, []).

-spec preorderTraversalHelper(TreeNode(), [integer()]) -> [integer()].
preorderTraversalHelper(null, Acc) ->
  lists:reverse(Acc);
preorderTraversalHelper(TreeNode, Acc) ->
  Val = TreeNode#treeNode.val,
  Left = TreeNode#treeNode.left,
  Right = TreeNode#treeNode.right,
  preorderTraversalHelper(Left, [Val | preorderTraversalHelper(Right, Acc)]).

-type TreeNode() :: null | #treeNode{val :: integer(), left :: TreeNode(), right :: TreeNode()}.
-record(treeNode, {val, left, right}).