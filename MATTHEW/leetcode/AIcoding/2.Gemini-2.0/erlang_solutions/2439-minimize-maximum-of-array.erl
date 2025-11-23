-module(minimize_maximum_of_array).
-export([minimize_array_value/1]).

minimize_array_value(Nums) ->
  minimize_array_value(Nums, 0, 0, 0).

minimize_array_value([], _Sum, Max, _Idx) ->
  Max;
minimize_array_value([Num | Rest], Sum, Max, Idx) ->
  NewSum = Sum + Num,
  NewMax = max(Max, ceiling(NewSum / (Idx + 1))),
  minimize_array_value(Rest, NewSum, NewMax, Idx + 1).

ceiling(X) ->
  Truncated = trunc(X),
  if
    X == Truncated ->
      Truncated;
    true ->
      Truncated + 1
  end.