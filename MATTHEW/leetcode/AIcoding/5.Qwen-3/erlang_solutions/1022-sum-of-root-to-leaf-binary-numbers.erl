-module(solution).
-export([sum_root_to_leaf/1]).

sum_root_to_leaf(Tree) ->
    sum_root_to_leaf(Tree, 0).

sum_root_to_leaf(nil, _) ->
    0;
sum_root_to_leaf({Val, Left, Right}, Acc) ->
    NewAcc = (Acc bsl 1) + Val,
    sum_root_to_leaf(Left, NewAcc) + sum_root_to_leaf(Right, NewAcc).