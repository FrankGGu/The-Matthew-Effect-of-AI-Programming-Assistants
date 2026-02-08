-module(accumulate_bst).
-export([convertBST/1]).

convertBST(Root) ->
    {_, NewRoot} = convertBSTHelper(Root, 0),
    NewRoot.

convertBSTHelper(null, Sum) ->
    {Sum, null};
convertBSTHelper(TreeNode, Sum) ->
    {RightSum, Right} = convertBSTHelper(TreeNode#node.right, Sum),
    NewSum = RightSum + TreeNode#node.val,
    TreeNode2 = TreeNode#node{val = NewSum},
    {LeftSum, Left} = convertBSTHelper(TreeNode#node.left, NewSum),
    NewNode = TreeNode2#node{left = Left, right = Right},
    {LeftSum, NewNode}.

-record(node, {val, left = null, right = null}).