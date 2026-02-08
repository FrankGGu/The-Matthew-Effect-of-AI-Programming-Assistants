-module(sum_root_to_leaf).
-export([sum_root_to_leaf/1]).

-spec sum_root_to_leaf(Tree :: tree()) -> integer().
sum_root_to_leaf(Root) ->
    sum_root_to_leaf_helper(Root, 0).

-spec sum_root_to_leaf_helper(Tree :: tree(), Acc :: integer()) -> integer().
sum_root_to_leaf_helper(null, _Acc) ->
    0;
sum_root_to_leaf_helper({val, null, null}, Acc) ->
    (Acc * 2 + val);
sum_root_to_leaf_helper({val, Left, Right}, Acc) ->
    sum_root_to_leaf_helper(Left, Acc * 2 + val) + sum_root_to_leaf_helper(Right, Acc * 2 + val).

-type tree() :: null | {integer(), tree(), tree()}.