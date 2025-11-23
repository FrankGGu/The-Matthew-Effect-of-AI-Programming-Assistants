-module(solution).
-export([maxPoints/1]).

maxPoints(Grid) ->
    MaxPoints = max_points(Grid, 0, 0, length(Grid), length(hd(Grid))),
    MaxPoints.

max_points(_, Row, Col, Rows, Cols) when Row >= Rows -> 0;
max_points(_, Row, Col, Rows, Cols) when Col >= Cols -> max_points(Grid, Row + 1, 0, Rows, Cols);
max_points(Grid, Row, Col, Rows, Cols) ->
    Points = lists:nth(Col + 1, lists:nth(Row + 1, Grid)),
    MaxFromNextCol = max_points(Grid, Row, Col + 1, Rows, Cols),
    Points + MaxFromNextCol.