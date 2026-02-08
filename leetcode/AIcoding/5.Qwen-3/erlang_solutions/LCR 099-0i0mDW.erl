-module(min_path_sum).
-export([minPathSum/1]).

minPathSum(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    DP = array:new({size, Rows}, {default, 0}),
    array:set(0, 0, array:get(0, 0, Grid), DP),
    minPathSum(Grid, DP, Rows, Cols).

minPathSum(_, _, 0, _) -> array:get(0, 0);
minPathSum(Grid, DP, Row, Col) ->
    Current = array:get(Row-1, Col-1, Grid),
    Up = if Row > 1 -> array:get(Row-2, Col-1, DP); true -> infinity end,
    Left = if Col > 1 -> array:get(Row-1, Col-2, DP); true -> infinity end,
    NewVal = Current + min(Up, Left),
    DP1 = array:set(Row-1, Col-1, NewVal, DP),
    case Col of
        Cols -> minPathSum(Grid, DP1, Row-1, Cols);
        _ -> minPathSum(Grid, DP1, Row, Col+1)
    end.