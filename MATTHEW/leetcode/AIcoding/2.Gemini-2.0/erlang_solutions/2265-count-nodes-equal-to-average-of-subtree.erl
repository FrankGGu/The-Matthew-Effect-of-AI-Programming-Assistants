-module(count_nodes_equal_to_average_of_subtree).
-export([count_nodes_equal_to_average_of_subtree/1]).

count_nodes_equal_to_average_of_subtree(Root) ->
    {_, Count} = count_nodes_equal_to_average_of_subtree_helper(Root, 0).
    Count.

count_nodes_equal_to_average_of_subtree_helper(null, Count) ->
    {0, 0};
count_nodes_equal_to_average_of_subtree_helper(TreeNode, Count) ->
    Val = TreeNode#treeNode.val,
    Left = TreeNode#treeNode.left,
    Right = TreeNode#treeNode.right,
    {LeftSum, LeftCount} = count_nodes_equal_to_average_of_subtree_helper(Left, 0),
    {RightSum, RightCount} = count_nodes_equal_to_average_of_subtree_helper(Right, 0),
    Sum = Val + LeftSum + RightSum,
    TotalCount = 1 + LeftCount + RightCount,
    Avg = Sum div TotalCount,
    NewCount = if Avg =:= Val then Count + 1 else Count end,
    {Sum, NewCount + LeftCount + RightCount}.