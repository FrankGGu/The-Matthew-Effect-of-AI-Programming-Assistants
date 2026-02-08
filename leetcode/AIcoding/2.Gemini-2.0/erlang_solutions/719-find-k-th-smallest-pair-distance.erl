-module(find_kth_smallest_pair_distance).
-export([findKthSmallestPair/2]).

findKthSmallestPair(Nums, K) ->
  lists:sort(Nums, fun(A, B) -> A < B end) ->
  Len = length(Nums),
  Low = 0,
  High = lists:nth(Len, Nums) - lists:nth(1, Nums),
  findKthSmallestPairHelper(Nums, K, Low, High).

findKthSmallestPairHelper(Nums, K, Low, High) ->
  if Low >= High ->
    Low;
  true ->
    Mid = Low + (High - Low) div 2,
    Count = countPairs(Nums, Mid),
    if Count < K ->
      findKthSmallestPairHelper(Nums, K, Mid + 1, High);
    true ->
      findKthSmallestPairHelper(Nums, K, Low, Mid)
  end.

countPairs(Nums, Mid) ->
  countPairsHelper(Nums, Mid, 0, 0).

countPairsHelper(_Nums, _Mid, Len, Len) ->
  0;
countPairsHelper(Nums, Mid, I, Count) ->
  J = findRight(Nums, I, Mid),
  if J >= length(Nums) ->
    Count;
  true ->
    countPairsHelper(Nums, Mid, I + 1, Count + J - I - 1)
  end.

findRight(Nums, I, Mid) ->
  findRightHelper(Nums, I, Mid, I + 1, length(Nums)).

findRightHelper(Nums, I, Mid, Low, High) ->
  if Low >= High ->
    Low;
  true ->
    MidIndex = Low + (High - Low) div 2,
    if lists:nth(MidIndex, Nums) - lists:nth(I + 1, Nums) =< Mid ->
      findRightHelper(Nums, I, Mid, MidIndex + 1, High);
    true ->
      findRightHelper(Nums, I, Mid, Low, MidIndex)
  end.