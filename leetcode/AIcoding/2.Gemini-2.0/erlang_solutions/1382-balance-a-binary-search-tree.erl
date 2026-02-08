-module(balance_bst).
-export([balance_bst/1]).

-spec balance_bst(TreeNode()) -> TreeNode().
balance_bst(Root) ->
  List = inorder_traversal(Root, []),
  build_balanced_bst(List).

inorder_traversal(null, Acc) ->
  lists:reverse(Acc);
inorder_traversal(TreeNode, Acc) ->
  inorder_traversal(TreeNode#tree_node.left, [TreeNode#tree_node.val | inorder_traversal(TreeNode#tree_node.right, Acc)]).

build_balanced_bst(List) ->
  build_balanced_bst_helper(List, 0, length(List) - 1).

build_balanced_bst_helper(_List, Low, High) when Low > High ->
  null;
build_balanced_bst_helper(List, Low, High) ->
  Mid = (Low + High) div 2,
  RootVal = lists:nth(Mid + 1, List),
  Left = build_balanced_bst_helper(List, Low, Mid - 1),
  Right = build_balanced_bst_helper(List, Mid + 1, High),
  #tree_node{val = RootVal, left = Left, right = Right}.

-record(tree_node, {val, left = null, right = null}).