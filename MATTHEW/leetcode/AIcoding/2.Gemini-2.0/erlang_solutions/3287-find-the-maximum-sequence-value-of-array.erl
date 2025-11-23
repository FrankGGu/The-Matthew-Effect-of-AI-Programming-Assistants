-module(maximum_sequence_value).
-export([maximum_sum/1]).

maximum_sum(Nums) ->
  maximum_sum(Nums, 0, 0).

maximum_sum([], MaxSoFar, CurrentMax) ->
  max(MaxSoFar, CurrentMax);
maximum_sum([H|T], MaxSoFar, CurrentMax) ->
  NewCurrentMax = max(0, CurrentMax + H),
  NewMaxSoFar = max(MaxSoFar, NewCurrentMax),
  maximum_sum(T, NewMaxSoFar, NewCurrentMax).