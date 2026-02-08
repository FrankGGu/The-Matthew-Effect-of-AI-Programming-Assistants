-module(subset_xor_totals).
-export([subsetXORSum/1]).

subsetXORSum(Nums) ->
  lists:foldl(fun(Num, Acc) -> Acc + Num end, 0, xor_sums(Nums)).

xor_sums(Nums) ->
  xor_sums(Nums, []).

xor_sums([], Acc) ->
  Acc;
xor_sums([H|T], Acc) ->
  NewAcc = lists:foldl(fun(X, A) -> [X xor H|A] end, [H], Acc),
  xor_sums(T, Acc ++ NewAcc).