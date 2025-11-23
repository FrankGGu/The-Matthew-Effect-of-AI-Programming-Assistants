-module(min_operations).
-export([minimum_operations/2]).

minimum_operations(X, Y) ->
  minimum_operations(X, Y, 0).

minimum_operations(X, Y, Count) ->
  if
    X == Y ->
      Count;
    X < Y ->
      Count + Y - X;
    true ->
      Op1 = minimum_operations(X - 1, Y, Count + 1),
      Op2 = minimum_operations(X + 1, Y, Count + 1),
      Op3 = minimum_operations(X div 2, Y, Count + 1 + X rem 2),
      Op4 = minimum_operations((X + 1) div 2, Y, Count + 1 + 1 - X rem 2),
      min([Op1, Op2, Op3, Op4])
  end.

min(List) ->
  lists:min(List).