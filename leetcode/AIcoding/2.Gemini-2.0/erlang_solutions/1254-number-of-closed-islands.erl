-module(closed_islands).
-export([num_closed_islands/1]).

num_closed_islands(Grid) ->
  {Rows, Cols} = grid_size(Grid),
  NewGrid = mark_boundary_water(Grid, Rows, Cols),
  count_islands(NewGrid).

grid_size(Grid) ->
  {length(Grid), length(hd(Grid))}.

mark_boundary_water(Grid, Rows, Cols) ->
  lists:foldl(
    fun(Row, AccGrid) ->
      mark_row(Row, AccGrid, Rows, Cols)
    end,
    Grid,
    lists:seq(1, Rows)
  ).

mark_row(Row, Grid, Rows, Cols) ->
  Grid1 = mark_cell(Grid, Row, 1, Rows, Cols),
  mark_cell(Grid1, Row, Cols, Rows, Cols).

mark_cell(Grid, Row, Col, Rows, Cols) ->
  case get_cell(Grid, Row, Col) of
    1 ->
      flood_fill(Grid, Row, Col, Rows, Cols);
    _ ->
      Grid
  end.

flood_fill(Grid, Row, Col, Rows, Cols) ->
  case get_cell(Grid, Row, Col) of
    1 ->
      NewGrid = set_cell(Grid, Row, Col, 0),
      flood_fill(
        flood_fill(
          flood_fill(
            flood_fill(NewGrid, Row + 1, Col, Rows, Cols),
            Row - 1,
            Col,
            Rows,
            Cols
          ),
          Row,
          Col + 1,
          Rows,
          Cols
        ),
        Row,
        Col - 1,
        Rows,
        Cols
      );
    _ ->
      Grid
  end.

get_cell(Grid, Row, Col) ->
  try
    lists:nth(Col, lists:nth(Row, Grid))
  catch
    _:_ ->
      0
  end.

set_cell(Grid, Row, Col, Value) ->
  lists:update(
    Row,
    lists:update(Col, Value, lists:nth(Row, Grid)),
    Grid
  ).

count_islands(Grid) ->
  {Rows, Cols} = grid_size(Grid),
  count_islands_helper(Grid, 1, 1, Rows, Cols, 0).

count_islands_helper(Grid, Row, Col, Rows, Cols, Count) ->
  case get_cell(Grid, Row, Col) of
    1 ->
      NewGrid = flood_fill(Grid, Row, Col, Rows, Cols),
      NextRow = Row + (Col div Cols),
      NextCol = (Col rem Cols) + 1,
      if
        NextRow > Rows ->
          Count + 1;
        true ->
          count_islands_helper(NewGrid, NextRow, NextCol, Rows, Cols, Count + 1)
      end;
    _ ->
      NextRow = Row + (Col div Cols),
      NextCol = (Col rem Cols) + 1,
      if
        NextRow > Rows ->
          Count;
        true ->
          count_islands_helper(Grid, NextRow, NextCol, Rows, Cols, Count)
      end
  end.