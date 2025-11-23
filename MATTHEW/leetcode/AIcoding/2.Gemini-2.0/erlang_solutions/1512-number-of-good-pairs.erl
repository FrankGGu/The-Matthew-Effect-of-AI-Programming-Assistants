-module(good_pairs).
-export([num_identical_pairs/1]).

num_identical_pairs(Nums) ->
    num_identical_pairs(Nums, 0).

num_identical_pairs([], Acc) ->
    Acc;
num_identical_pairs([H|T], Acc) ->
    Pairs = lists:filter(fun(X) -> X == H end, T),
    NewAcc = Acc + length(Pairs),
    num_identical_pairs(T, NewAcc).