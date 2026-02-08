-module(solution).
-export([sum_numbers/1]).

-spec sum_numbers(TreeNode()) -> integer().
sum_numbers(Root) ->
    sum_numbers(Root, 0).

sum_numbers(null, Acc) ->
    0;
sum_numbers(TreeNode, Acc) ->
    Val = TreeNode#tree_node.val,
    Left = TreeNode#tree_node.left,
    Right = TreeNode#tree_node.right,
    NewAcc = Acc * 10 + Val,
    case {Left, Right} of
        {null, null} ->
            NewAcc;
        {null, _} ->
            sum_numbers(Right, NewAcc);
        {_, null} ->
            sum_numbers(Left, NewAcc);
        {_, _} ->
            sum_numbers(Left, NewAcc) + sum_numbers(Right, NewAcc)
    end.

-record(tree_node, {val, left, right}).