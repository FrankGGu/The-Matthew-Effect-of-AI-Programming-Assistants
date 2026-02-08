-module(solution).
-export([sum_root_to_leaf/1]).

-record(tree, {val, left, right}).

sum_root_to_leaf(Tree) ->
    sum_root_to_leaf(Tree, 0).

sum_root_to_leaf(nil, _) ->
    0;
sum_root_to_leaf(Tree, CurrentSum) ->
    NewSum = (CurrentSum bsl 1) bor Tree#tree.val,
    case {Tree#tree.left, Tree#tree.right} of
        {nil, nil} -> NewSum;
        {Left, Right} -> 
            sum_root_to_leaf(Left, NewSum) + sum_root_to_leaf(Right, NewSum)
    end.