-module(solution).
-export([sum_numbers/1]).

sum_numbers(Root) ->
    sum_numbers_helper(Root, 0).

sum_numbers_helper(null, Acc) ->
    0;
sum_numbers_helper(TreeNode, Acc) ->
    Val = maps:get(val, TreeNode),
    NewAcc = Acc * 10 + Val,
    Left = maps:get(left, TreeNode, null),
    Right = maps:get(right, TreeNode, null),
    case {Left, Right} of
        {null, null} ->
            NewAcc;
        {L, R} ->
            sum_numbers_helper(L, NewAcc) + sum_numbers_helper(R, NewAcc)
    end.