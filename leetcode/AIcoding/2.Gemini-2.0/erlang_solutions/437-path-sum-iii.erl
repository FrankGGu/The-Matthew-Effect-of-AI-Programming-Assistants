-module(path_sum_iii).
-export([path_sum/2]).

path_sum(Root, TargetSum) ->
    path_sum_helper(Root, TargetSum, []).

path_sum_helper(null, _, _) ->
    0;
path_sum_helper(TreeNode, TargetSum, Path) ->
    Val = TreeNode#tree.val,
    Left = TreeNode#tree.left,
    Right = TreeNode#tree.right,
    NewPath = [Val | Path],
    Count = lists:foldl(fun(Sum, Acc) ->
                                if Sum =:= TargetSum then
                                    Acc + 1
                                else
                                    Acc
                                end
                            end, 0, sums(NewPath)),
    Count + path_sum_helper(Left, TargetSum, NewPath) + path_sum_helper(Right, TargetSum, NewPath).

sums(List) ->
    sums_helper(List, []).

sums_helper([], Acc) ->
    Acc;
sums_helper([H|T], Acc) ->
    Sum = lists:sum([H|T]),
    sums_helper(T, [Sum | Acc]).

-record(tree, {val, left, right}).