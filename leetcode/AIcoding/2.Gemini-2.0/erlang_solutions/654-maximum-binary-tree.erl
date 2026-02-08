-module(maximum_binary_tree).
-export([construct_maximum_binary_tree/1]).

-record(tree_node, {val, left, right}).

construct_maximum_binary_tree(Nums) ->
    construct_maximum_binary_tree(Nums, 0, length(Nums) - 1).

construct_maximum_binary_tree(Nums, L, R) when L > R ->
    null;
construct_maximum_binary_tree(Nums, L, R) ->
    {MaxIndex, _} = find_max(Nums, L, R),
    #tree_node{
        val = lists:nth(MaxIndex + 1, Nums),
        left = construct_maximum_binary_tree(Nums, L, MaxIndex - 1),
        right = construct_maximum_binary_tree(Nums, MaxIndex + 1, R)
    }.

find_max(Nums, L, R) ->
    find_max(Nums, L, R, L, lists:nth(L + 1, Nums)).

find_max(Nums, L, R, I, MaxVal) when I > R ->
    {L, MaxVal};
find_max(Nums, L, R, I, MaxVal) ->
    Val = lists:nth(I + 1, Nums),
    if
        Val > MaxVal ->
            find_max(Nums, L, R, I + 1, Val);
        true ->
            find_max(Nums, L, R, I + 1, MaxVal)
    end.

null -> null.