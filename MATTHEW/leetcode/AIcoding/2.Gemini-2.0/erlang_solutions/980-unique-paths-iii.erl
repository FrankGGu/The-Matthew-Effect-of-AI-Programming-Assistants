-module(unique_paths_iii).
-export([unique_paths_iii/1, solve/4]).

unique_paths_iii(Grid) ->
  {StartRow, StartCol, Empty} = find_start_empty(Grid),
  solve(Grid, StartRow, StartCol, Empty, 0).

find_start_empty(Grid) ->
  find_start_empty(Grid, 0, 0, 0).

find_start_empty(Grid, Row, Col, Empty) ->
  case grid_get(Grid, Row, Col) of
    none ->
      {Row, Col, Empty};
    1 ->
      find_start_empty(Grid, Row, Col, Empty - 1);
    2 ->
      find_start_empty(Grid, Row, Col, Empty);
    0 ->
      find_start_empty(Grid, Row, Col, Empty - 1);
    _ ->
      find_start_empty(Grid, Row, Col + 1, Empty)
  end.

find_start_empty(Grid, Row, Col, Empty) when Col >= length(hd(Grid)) ->
  find_start_empty(Grid, Row + 1, 0, Empty);

find_start_empty(Grid, Row, Col, Empty) when Row >= length(Grid) ->
  {0, 0, Empty + length(Grid) * length(hd(Grid))}.

solve(Grid, Row, Col, Empty, Count) ->
  case grid_get(Grid, Row, Col) of
    none ->
      Count;
    -1 ->
      Count;
    2 when Empty == 1 ->
      Count + 1;
    2 ->
      Count;
    _ ->
      NewGrid = grid_set(Grid, Row, Col, -1),
      Solve1 = solve(NewGrid, Row + 1, Col, Empty - 1, Count),
      Solve2 = solve(NewGrid, Row - 1, Col, Empty - 1, Count),
      Solve3 = solve(NewGrid, Row, Col + 1, Empty - 1, Count),
      Solve4 = solve(NewGrid, Row, Col - 1, Empty - 1, Count),
      Solve1 + Solve2 + Solve3 + Solve4
  end.

grid_get(Grid, Row, Col) ->
  try
    lists:nth(Col + 1, lists:nth(Row + 1, Grid))
  catch
    _:_ ->
      none
  end.

grid_set(Grid, Row, Col, Value) ->
  lists:replace(Row + 1, lists:replace(Col + 1, element(Row + 1, Grid), Value), Grid).