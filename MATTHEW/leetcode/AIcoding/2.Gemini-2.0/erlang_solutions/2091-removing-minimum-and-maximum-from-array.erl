-module(removing_minimum_and_maximum).
-export([min_operations/1]).

min_operations(Nums) ->
  N = length(Nums),
  {MinIndex, _} = lists:min(lists:zip(lists:seq(1, N), Nums)),
  {MaxIndex, _} = lists:max(lists:zip(lists:seq(1, N), lists:map(fun(X) -> -X end, Nums))),
  MinIdx = min(MinIndex, MaxIndex),
  MaxIdx = max(MinIndex, MaxIndex),
  min([MaxIdx, N - MinIdx + 1, MinIdx + (N - MaxIdx + 1)]).