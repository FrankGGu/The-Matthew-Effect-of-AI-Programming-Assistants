-module(minimum_operations).
-export([minOperations/2]).

minOperations(Nums, Queries) ->
  SortedNums = lists:sort(Nums),
  lists:map(fun(Q) -> calculate_operations(SortedNums, Q) end, Queries).

calculate_operations(Nums, Q) ->
  {Lower, Upper} = lists:partition(fun(X) -> X < Q end, Nums),
  LowerSum = lists:sum(Lower),
  UpperSum = lists:sum(Nums) - LowerSum,
  LowerCount = length(Lower),
  UpperCount = length(Nums) - LowerCount,
  (Q * LowerCount - LowerSum) + (UpperSum - Q * UpperCount).