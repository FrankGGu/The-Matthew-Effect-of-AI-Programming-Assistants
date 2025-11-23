-module(apple_redistribution).
-export([redistribute_apples/2]).

redistribute_apples(boxes, apples) ->
  Len = length(boxes),
  Sum = lists:sum(boxes),
  if Sum >= apples then
    Result = [I - (apples div Len) || I <- boxes],
    Remainder = apples rem Len,
    redistribute_remainder(Result, Remainder, [])
  else
    -1
  end.

redistribute_remainder(Boxes, 0, Acc) ->
  lists:reverse(Acc ++ Boxes);
redistribute_remainder([H|T], Remainder, Acc) ->
  redistribute_remainder(T, Remainder - 1, Acc ++ [H - 1]).