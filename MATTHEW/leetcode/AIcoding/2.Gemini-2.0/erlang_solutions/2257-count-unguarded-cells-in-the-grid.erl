-module(unguarded_cells).
-export([count_unguarded/3]).

count_unguarded(M, N, Guards) ->
  grid(M, N, Guards).

grid(M, N, Guards) ->
  Grid = lists:duplicate(M, lists:duplicate(N, 0)),
  GuardedGrid = mark_guards(Guards, Grid, M, N),
  mark_visible(GuardedGrid, M, N).

mark_guards(Guards, Grid, M, N) ->
  lists:foldl(fun([Row, Col], AccGrid) ->
                  set_guard(Row, Col, AccGrid, M, N)
              end, Grid, Guards).

set_guard(Row, Col, Grid, _M, _N) ->
  update_grid(Row, Col, 1, Grid).

mark_visible(Grid, M, N) ->
  NewGrid1 = mark_horizontal(Grid, M, N),
  NewGrid2 = mark_vertical(NewGrid1, M, N),
  count_unguarded_cells(NewGrid2).

mark_horizontal(Grid, M, N) ->
  mark_horizontal_helper(Grid, 0, M, N).

mark_horizontal_helper(Grid, Row, M, N) ->
  if Row >= M ->
    Grid
  else
    NewRow = mark_horizontal_row(lists:nth(Row + 1, Grid), 0, N, 0),
    NewGrid = update_row(Row, NewRow, Grid),
    mark_horizontal_helper(NewGrid, Row + 1, M, N)
  end.

mark_horizontal_row(Row, Col, N, Blocked) ->
  if Col >= N ->
    Row
  else
    Value = lists:nth(Col + 1, Row),
    case {Value, Blocked} of
      {1, _} ->
        mark_horizontal_row(Row, Col + 1, N, 1);
      {2, _} ->
        mark_horizontal_row(Row, Col + 1, N, 1);
      {0, 0} ->
        NewRow = update_cell_in_row(Col, 2, Row),
        mark_horizontal_row(NewRow, Col + 1, N, 0);
      {0, 1} ->
        mark_horizontal_row(Row, Col + 1, N, 1)
    end
  end.

mark_vertical(Grid, M, N) ->
  mark_vertical_helper(Grid, 0, N, M).

mark_vertical_helper(Grid, Col, N, M) ->
  if Col >= N ->
    Grid
  else
    NewGrid = mark_vertical_col(Grid, Col, 0, M, 0),
    mark_vertical_helper(NewGrid, Col + 1, N, M)
  end.

mark_vertical_col(Grid, Col, Row, M, Blocked) ->
  if Row >= M ->
    Grid
  else
    Value = lists:nth(Col + 1, lists:nth(Row + 1, Grid)),
    case {Value, Blocked} of
      {1, _} ->
        mark_vertical_col(Grid, Col, Row + 1, M, 1);
      {2, _} ->
        mark_vertical_col(Grid, Col, Row + 1, M, 1);
      {0, 0} ->
        NewGrid = update_cell(Row, Col, 2, Grid),
        mark_vertical_col(NewGrid, Col, Row + 1, M, 0);
      {0, 1} ->
        mark_vertical_col(Grid, Col, Row + 1, M, 1)
    end
  end.

count_unguarded_cells(Grid) ->
  lists:foldl(fun(Row, Acc) ->
                  Acc + count_unguarded_cells_in_row(Row)
              end, 0, Grid).

count_unguarded_cells_in_row(Row) ->
  lists:foldl(fun(Cell, Acc) ->
                  if Cell == 0 ->
                    Acc + 1
                  else
                    Acc
                  end
              end, 0, Row).

update_grid(Row, Col, Value, Grid) ->
  update_cell(Row - 1, Col - 1, Value, Grid).

update_cell(Row, Col, Value, Grid) ->
  RowList = lists:nth(Row + 1, Grid),
  NewRowList = update_cell_in_row(Col, Value, RowList),
  update_row(Row, NewRowList, Grid).

update_cell_in_row(Col, Value, RowList) ->
  lists:nthreplace(Col + 1, Value, RowList).

update_row(Row, NewRow, Grid) ->
  lists:nthreplace(Row + 1, NewRow, Grid).