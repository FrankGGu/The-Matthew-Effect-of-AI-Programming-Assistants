-module(knight_tour).
-export([check_valid_grid/1]).

check_valid_grid(Grid) ->
  {Rows, Cols} = grid_size(Grid),
  case check_knight_tour(Grid, Rows, Cols, 0, {0, 0}) of
    true -> true;
    false -> false
  end.

grid_size(Grid) ->
  Rows = length(Grid),
  Cols = length(hd(Grid)),
  {Rows, Cols}.

check_knight_tour(_Grid, _Rows, _Cols, Target, _Pos) when Target > _Rows * _Cols - 1 ->
  true;
check_knight_tour(Grid, Rows, Cols, Target, {Row, Col}) ->
  case get_value(Grid, Row, Col) of
    Target ->
      NextMoves = knight_moves(Row, Col, Rows, Cols),
      lists:any(fun({NextRow, NextCol}) ->
                    check_knight_tour(Grid, Rows, Cols, Target + 1, {NextRow, NextCol})
                end, NextMoves);
    _ ->
      false
  end.

knight_moves(Row, Col, Rows, Cols) ->
  Moves = [{Row - 2, Col - 1}, {Row - 2, Col + 1},
           {Row - 1, Col - 2}, {Row - 1, Col + 2},
           {Row + 1, Col - 2}, {Row + 1, Col + 2},
           {Row + 2, Col - 1}, {Row + 2, Col + 1}],
  lists:filter(fun({R, C}) ->
                  R >= 0 and R < Rows and C >= 0 and C < Cols
               end, Moves).

get_value(Grid, Row, Col) ->
  try
    lists:nth(Col + 1, lists:nth(Row + 1, Grid))
  catch
    _:_ ->
      -1
  end.