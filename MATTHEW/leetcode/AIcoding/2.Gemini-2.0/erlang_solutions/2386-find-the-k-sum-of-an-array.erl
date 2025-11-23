-module(find_k_sum).
-export([k_sum/2]).

k_sum(Nums, K) ->
  SortedNums = lists:sort(Nums),
  N = length(SortedNums),
  PrefixSum = [0 | lists:scanl(fun(X, Acc) -> X + Acc end, 0, SortedNums)],

  PosSum = PrefixSum -- [0],
  NegSum = PrefixSum -- [lists:last(PrefixSum)],

  PosSumSorted = lists:sort(PosSum),
  NegSumSorted = lists:reverse(lists:sort(lists:map(fun(X) -> -X end, NegSum))),

  AllSums = lists:merge(PosSumSorted, NegSumSorted),

  lists:nth(K, AllSums).