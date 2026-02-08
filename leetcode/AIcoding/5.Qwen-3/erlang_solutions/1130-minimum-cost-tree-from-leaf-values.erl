-module(minimum_cost_tree_from_leaf_values).
-export([mct_from_leaf_values/1]).

mct_from_leaf_values(Leafs) ->
    mct_from_leaf_values(Leafs, []).

mct_from_leaf_values([], [Root]) ->
    Root;
mct_from_leaf_values([A, B | Rest], Acc) ->
    Cost = A + B,
    mct_from_leaf_values([A + B | Rest], [Cost | Acc]);
mct_from_leaf_values([X | Rest], Acc) ->
    mct_from_leaf_values(Rest, [X | Acc]).