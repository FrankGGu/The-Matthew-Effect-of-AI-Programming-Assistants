-module(mctFromLeafValues).
-export([mctFromLeafValues/1]).

mctFromLeafValues(Arr) ->
  mctFromLeafValues(Arr, []).

mctFromLeafValues([], Stack) ->
  case Stack of
    [Val] ->
      0;
    [Val1, Val2 | Rest] ->
      Val1 * Val2 + mctFromLeafValues([], [Val2 | Rest])
  end;
mctFromLeafValues([H | T], []) ->
  mctFromLeafValues(T, [H]);
mctFromLeafValues([H | T], [Top | Rest]) ->
  if
    H >= Top ->
      mctFromLeafValues(T, [H | [Top | Rest]]);
    true ->
      {Cost, NewStack} = popUntilLarger(Top, H, Rest, 0),
      mctFromLeafValues(T, [H | NewStack], Cost)
  end.

popUntilLarger(Top, H, [], Cost) ->
  {Cost + Top * H, []};
popUntilLarger(Top, H, [NextTop | Rest], Cost) ->
  if
    NextTop =< H ->
      {NewCost, NewStack} = popUntilLarger(NextTop, H, Rest, Cost + Top * NextTop),
      {NewCost, NewStack};
    true ->
      {Cost + Top * H, [NextTop | Rest]}
  end.

mctFromLeafValues(Arr, Stack, Cost) ->
  mctFromLeafValues(Arr, Stack, Cost, 0).

mctFromLeafValues([], Stack, Cost) ->
  case Stack of
    [Val] ->
      Cost;
    [Val1, Val2 | Rest] ->
      mctFromLeafValues([], [Val2 | Rest], Cost + Val1 * Val2)
  end;
mctFromLeafValues([H | T], [], _, Cost) ->
  mctFromLeafValues(T, [H], Cost);
mctFromLeafValues([H | T], [Top | Rest], Cost) ->
  if
    H >= Top ->
      mctFromLeafValues(T, [H | [Top | Rest]], Cost);
    true ->
      {NewCost, NewStack} = popUntilLargerWithCost(Top, H, Rest, Cost),
      mctFromLeafValues(T, [H | NewStack], NewCost)
  end.

popUntilLargerWithCost(Top, H, [], Cost) ->
  {Cost + Top * H, []};
popUntilLargerWithCost(Top, H, [NextTop | Rest], Cost) ->
  if
    NextTop =< H ->
      {NewCost, NewStack} = popUntilLargerWithCost(NextTop, H, Rest, Cost + Top * NextTop),
      {NewCost, NewStack};
    true ->
      {Cost + Top * H, [NextTop | Rest]}
  end.