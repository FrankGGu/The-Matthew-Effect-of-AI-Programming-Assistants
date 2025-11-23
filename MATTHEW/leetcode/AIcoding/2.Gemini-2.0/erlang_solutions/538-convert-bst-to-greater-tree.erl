-module(greater_tree).
-export([convertBST/1]).

convertBST(Root) ->
  {_, NewRoot} = convertBSTHelper(Root, 0),
  NewRoot.

convertBSTHelper(null, Sum) ->
  {Sum, null};
convertBSTHelper(TreeNode, Sum) ->
  {RightSum, Right} = convertBSTHelper(TreeNode#node.right, Sum),
  NewVal = TreeNode#node.val + RightSum,
  {LeftSum, Left} = convertBSTHelper(TreeNode#node.left, NewVal),
  NewNode = TreeNode#node{val = NewVal, right = Right, left = Left},
  {LeftSum, NewNode}.

-record(node, {val, left = null, right = null}).