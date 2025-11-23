-module(fair_array).
-export([waysToMakeFair/1]).

waysToMakeFair(Nums) ->
  N = length(Nums),
  waysToMakeFair(Nums, 0, 0, 0, N).

waysToMakeFair(_Nums, EvenSum, OddSum, Count, 0) ->
  Count;
waysToMakeFair(Nums, EvenSum, OddSum, Count, N) ->
  Head = lists:nth(1, Nums),
  NewNums = lists:sublist(Nums, 2, length(Nums) - 1),

  NewEvenSum = EvenSum,
  NewOddSum = OddSum,

  if (EvenSum + getEvenSum(NewNums, 1) == OddSum + getOddSum(NewNums, 1)) ->
    waysToMakeFair(NewNums, EvenSum, OddSum, Count + 1, length(NewNums));
  true ->
    waysToMakeFair(NewNums, EvenSum, OddSum, Count, length(NewNums))
  end.

getEvenSum(Nums, Index) ->
  getEvenSum(Nums, Index, 0).

getEvenSum([], _Index, Acc) ->
  Acc;
getEvenSum([H|T], Index, Acc) ->
  if (Index rem 2) == 0 ->
    getEvenSum(T, Index+1, Acc + H);
  true ->
    getEvenSum(T, Index+1, Acc)
  end.

getOddSum(Nums, Index) ->
  getOddSum(Nums, Index, 0).

getOddSum([], _Index, Acc) ->
  Acc;
getOddSum([H|T], Index, Acc) ->
  if (Index rem 2) /= 0 ->
    getOddSum(T, Index+1, Acc + H);
  true ->
    getOddSum(T, Index+1, Acc)
  end.