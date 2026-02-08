-module(find_copy_arrays).
-export([num_identical_pairs/1]).

num_identical_pairs(Nums) ->
  num_identical_pairs(Nums, 0).

num_identical_pairs([], Acc) ->
  Acc;
num_identical_pairs([H|T], Acc) ->
  Count = lists:foldl(fun(X, C) -> if X == H -> C + 1; true -> C end end, 0, T),
  num_identical_pairs(T, Acc + Count).