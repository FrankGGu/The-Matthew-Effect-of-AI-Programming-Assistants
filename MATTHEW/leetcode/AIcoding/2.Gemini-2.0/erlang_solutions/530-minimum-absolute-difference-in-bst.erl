-module(min_abs_diff).
-export([getMinimumDifference/1]).

-spec getMinimumDifference(TreeNode::treeNode()) -> integer().
getMinimumDifference(Root) ->
  Values = inorderTraversal(Root),
  min_diff(Values, infinity).

inorderTraversal(null) ->
  [].
inorderTraversal(TreeNode) ->
  inorderTraversal(TreeNode#treeNode.left) ++
  [TreeNode#treeNode.val] ++
  inorderTraversal(TreeNode#treeNode.right).

min_diff([_], Min) ->
  Min;
min_diff([H1, H2 | T], Min) ->
  Diff = abs(H1 - H2),
  NewMin = min(Min, Diff),
  min_diff([H2 | T], NewMin).

min(A, B) ->
  if A < B -> A; true -> B end.

-type treeNode() :: #treeNode{val :: integer(), left :: treeNode() | null, right :: treeNode() | null}.
-record(treeNode, {val :: integer(), left :: treeNode() | null, right :: treeNode() | null}).