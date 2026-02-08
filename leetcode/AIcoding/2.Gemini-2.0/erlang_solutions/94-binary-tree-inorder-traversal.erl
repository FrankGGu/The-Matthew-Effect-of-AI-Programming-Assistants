-module(inorder_traversal).
-export([inorderTraversal/1]).

-spec inorderTraversal(TreeNode()) -> [integer()].
inorderTraversal(Root) ->
  inorderTraversal_helper(Root, []).

inorderTraversal_helper(null, Acc) ->
  lists:reverse(Acc);
inorderTraversal_helper(TreeNode, Acc) ->
  {Val, Left, Right} = TreeNode,
  Acc1 = inorderTraversal_helper(Left, Acc),
  Acc2 = [Val | Acc1],
  inorderTraversal_helper(Right, Acc2).

-type TreeNode() :: {integer(), TreeNode(), TreeNode()} | null.