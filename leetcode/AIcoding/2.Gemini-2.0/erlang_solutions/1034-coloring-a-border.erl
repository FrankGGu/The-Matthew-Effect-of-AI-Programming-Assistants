-module(coloring_border).
-export([color_border/3]).

color_border(Grid, Row, Col, Color) ->
  {Rows, Cols} = grid_size(Grid),
  Visited = gb_sets:empty(),
  {NewGrid, _} = dfs(Grid, Row, Col, Grid[Row][Col], Color, Rows, Cols, Visited),
  NewGrid.

dfs(Grid, Row, Col, OriginalColor, Color, Rows, Cols, Visited) ->
  if Row < 0 or Row >= Rows or Col < 0 or Col >= Cols then
    {Grid, false}
  else if gb_sets:is_element({Row, Col}, Visited) then
    {Grid, false}
  else if Grid[Row][Col] /= OriginalColor then
    {Grid, false}
  else
    Visited1 = gb_sets:add({Row, Col}, Visited),
    {NewGrid1, UpBorder} = dfs(Grid, Row - 1, Col, OriginalColor, Color, Rows, Cols, Visited1),
    {NewGrid2, DownBorder} = dfs(NewGrid1, Row + 1, Col, OriginalColor, Color, Rows, Cols, Visited1),
    {NewGrid3, LeftBorder} = dfs(NewGrid2, Row, Col - 1, OriginalColor, Color, Rows, Cols, Visited1),
    {NewGrid4, RightBorder} = dfs(NewGrid3, Row, Col + 1, OriginalColor, Color, Rows, Cols, Visited1),

    IsBorder = not (UpBorder and DownBorder and LeftBorder and RightBorder),

    if IsBorder then
      NewRow = lists:nth(Row + 1, NewGrid4),
      NewRow1 = lists:nth(Col + 1, NewRow),
      NewRow2 = lists:nth(Col + 1, lists:replace(NewRow, Col + 1, Color)),
      NewGrid5 = lists:replace(NewGrid4, Row + 1, NewRow2),
      {NewGrid5, false}
    else
      {NewGrid4, true}
    end
  end.

grid_size(Grid) ->
  Rows = length(Grid),
  Cols = length(lists:nth(1, Grid)),
  {Rows, Cols}.