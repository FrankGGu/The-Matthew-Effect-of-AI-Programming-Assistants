-module(minimum_distance).
-export([minimum_distance/1]).

minimum_distance(Word) ->
  minimum_distance(Word, -1, -1, 0).

minimum_distance(Word, Left, Right, Index) ->
  case Index =:= length(Word) of
    true ->
      0;
    false ->
      Char = element(Index + 1, list_to_tuple(Word)),
      Pos = char_code(Char) - char_code('A'),
      LeftDist = distance(Left, Pos) + minimum_distance(Word, Pos, Right, Index + 1),
      RightDist = distance(Right, Pos) + minimum_distance(Word, Left, Pos, Index + 1),
      min(LeftDist, RightDist)
  end.

distance(-1, _) ->
  0;
distance(_, -1) ->
  0;
distance(A, B) ->
  X1 = A rem 6,
  Y1 = A div 6,
  X2 = B rem 6,
  Y2 = B div 6,
  abs(X1 - X2) + abs(Y1 - Y2).

char_code(Char) ->
  list_to_integer(io_lib:format("~w", [Char])).