-module(good_pairs).
-export([num_identical_pairs/1]).

num_identical_pairs(Nums) ->
  num_identical_pairs(Nums, 0).

num_identical_pairs([], Acc) ->
  Acc;
num_identical_pairs([H|T], Acc) ->
  GoodPairs = lists:foldl(fun(X, Count) ->
                                  if X == H then
                                    Count + 1
                                  else
                                    Count
                                  end
                          end, 0, T),
  num_identical_pairs(T, Acc + GoodPairs).