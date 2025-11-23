-module(maximum_score_from_grid_operations).
-export([maximumScore/1]).

maximumScore(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    DP = array:new({size, Rows + 1}, {default, 0}),
    DP2 = array:new({size, Cols + 1}, {default, 0}),
    max_score(Grid, Rows, Cols, DP, DP2).

max_score(_, 0, _, _, _) -> 0;
max_score(Grid, Row, Col, DP, DP2) ->
    Value = lists:nth(Row, Grid),
    Current = lists:nth(Col, Value),
    Up = array:get(Row - 1, DP),
    Left = array:get(Col - 1, DP2),
    Max = max(Up, Left),
    NewDP = array:set(Row, Max + Current, DP),
    NewDP2 = array:set(Col, Max + Current, DP2),
    max_score(Grid, Row, Col - 1, NewDP, NewDP2).

max_score(Grid, Row, 0, DP, DP2) ->
    max_score(Grid, Row - 1, length(hd(Grid)), DP, DP2);
max_score(Grid, 0, Col, DP, DP2) ->
    max_score(Grid, 0, Col - 1, DP, DP2).