-module(find_special_integer).
-export([find_special_integer/1]).

find_special_integer(Arr) ->
  N = length(Arr),
  Threshold = N div 4,
  find_special_integer(Arr, Threshold).

find_special_integer([H | T], Threshold) ->
  find_special_integer(H, T, 1, Threshold);
find_special_integer(_, []) ->
  undefined.

find_special_integer(H, [H | T], Count, Threshold) ->
  NewCount = Count + 1,
  if NewCount > Threshold then
    H
  else
    find_special_integer(H, T, NewCount, Threshold)
  end;
find_special_integer(H, [NewH | T], _, Threshold) ->
  if NewH =:= H then
    find_special_integer(H,[NewH|T],1, Threshold)
  else
    find_special_integer(NewH, T, 1, Threshold)
  end.