-module(safe_walk).
-export([safe_walk/1]).

safe_walk(grid) ->
  {Rows, Cols} = grid_size(grid),
  safe_walk_helper(grid, 0, 0, Rows - 1, Cols - 1, []).

safe_walk_helper(_Grid, Row, Col, EndRow, EndCol, Path) when Row > EndRow orelse Col > EndCol ->
  [];
safe_walk_helper(_Grid, Row, Col, EndRow, EndCol, Path) when Row < 0 orelse Col < 0 ->
  [];
safe_walk_helper(Grid, Row, Col, EndRow, EndCol, Path) when lists:nth(Col + 1, lists:nth(Row + 1, Grid)) =:= 1 ->
  [];
safe_walk_helper(Grid, EndRow, EndCol, EndRow, EndCol, Path) ->
  lists:reverse([{EndRow, EndCol} | Path]);
safe_walk_helper(Grid, Row, Col, EndRow, EndCol, Path) ->
  Path1 = safe_walk_helper(Grid, Row + 1, Col, EndRow, EndCol, [{Row, Col} | Path]),
  Path2 = safe_walk_helper(Grid, Row, Col + 1, EndRow, EndCol, [{Row, Col} | Path]),

  case {Path1, Path2} of
    {[], []} -> [];
    {[], _} -> Path2;
    {_, []} -> Path1;
    {P1, P2} ->
      if length(P1) < length(P2) then
        P1
      else
        P2
      end
  end.

grid_size(Grid) ->
  Rows = length(Grid),
  Cols = length(lists:nth(1, Grid)),
  {Rows, Cols}.