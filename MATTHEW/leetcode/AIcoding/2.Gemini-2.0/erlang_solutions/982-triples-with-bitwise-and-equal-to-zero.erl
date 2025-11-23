-module(triples_with_bitwise_and_equal_to_zero).
-export([countTriplets/1]).

countTriplets(Nums) ->
  countTriplets(Nums, 0, 0).

countTriplets([], Acc, _) ->
  Acc;
countTriplets([Num | Rest], Acc, Max) ->
  countTriplets(Rest, Acc + countTripletsHelper(Num, Nums), Max).

countTripletsHelper(Num, Nums) ->
  countTripletsHelper(Num, Nums, 0).

countTripletsHelper(_, [], Acc) ->
  Acc;
countTripletsHelper(Num, [Num2 | Rest], Acc) ->
  countTripletsHelper(Num, Rest, Acc + countTripletsHelper2(Num, Num2, Nums)).

countTripletsHelper2(Num, Num2, Nums) ->
  countTripletsHelper2(Num, Num2, Nums, 0).

countTripletsHelper2(_, _, [], Acc) ->
  Acc;
countTripletsHelper2(Num, Num2, [Num3 | Rest], Acc) ->
  Result = if (Num band Num2 band Num3) == 0 -> 1; true -> 0 end,
  countTripletsHelper2(Num, Num2, Rest, Acc + Result).