-module(maximum_absolute_sum).
-export([maxAbsoluteSum/1]).

maxAbsoluteSum(Nums) ->
  maxAbsoluteSum(Nums, 0, 0, 0, 0).

maxAbsoluteSum([], MaxSoFar, MinSoFar, CurrMax, CurrMin) ->
  max(abs(MaxSoFar), abs(MinSoFar));
maxAbsoluteSum([Num | Rest], MaxSoFar, MinSoFar, CurrMax, CurrMin) ->
  NewCurrMax = max(0, CurrMax + Num),
  NewCurrMin = min(0, CurrMin + Num),
  NewMaxSoFar = max(MaxSoFar, NewCurrMax),
  NewMinSoFar = min(MinSoFar, NewCurrMin),
  maxAbsoluteSum(Rest, NewMaxSoFar, NewMinSoFar, NewCurrMax, NewCurrMin).

max(A, B) ->
  if A > B -> A; true -> B end.

min(A, B) ->
  if A < B -> A; true -> B end.