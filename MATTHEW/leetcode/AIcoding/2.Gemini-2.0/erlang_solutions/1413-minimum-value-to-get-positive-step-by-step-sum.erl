-module(minimum_value).
-export([min_start_value/1]).

min_start_value(Nums) ->
  min_start_value(Nums, 0, 0, 1).

min_start_value([], _, MinSoFar, StartValue) ->
  if MinSoFar >= 1 then
    StartValue
  else
    StartValue + (1 - MinSoFar)
  end;

min_start_value([H|T], Sum, MinSoFar, StartValue) ->
  NewSum = Sum + H,
  NewMin = min(MinSoFar, NewSum),
  min_start_value(T, NewSum, NewMin, StartValue).

min(A, B) ->
  if A < B then
    A
  else
    B
  end.