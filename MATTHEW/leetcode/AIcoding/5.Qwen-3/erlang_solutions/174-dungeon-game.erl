-module(dungeon_game).
-export([calculateMinimumHP/1]).

calculateMinimumHP(Dungeon) ->
    Rows = length(Dungeon),
    Cols = length(hd(Dungeon)),
    DP = array:new({0, Rows-1}, {0, Cols-1}, 0),
    DP2 = array:set(Rows-1, Cols-1, max(1, 1 - array:get(Rows-1, Cols-1, Dungeon)), DP),
    calculateMinimumHP(Dungeon, DP2, Rows-1, Cols-1).

calculateMinimumHP(_, DP, 0, 0) ->
    array:get(0, 0, DP);
calculateMinimumHP(Dungeon, DP, Row, Col) ->
    NextRow = Row + 1,
    NextCol = Col + 1,
    CurrentVal = array:get(Row, Col, Dungeon),
    Down = if
        NextRow < length(Dungeon) -> array:get(NextRow, Col, DP);
        true -> 0
    end,
    Right = if
        NextCol < length(hd(Dungeon)) -> array:get(Row, NextCol, DP);
        true -> 0
    end,
    Min = case {Down, Right} of
        {0, 0} -> 1;
        {D, 0} -> D;
        {0, R} -> R;
        {D, R} -> min(D, R)
    end,
    NewVal = max(1, Min - CurrentVal),
    DP2 = array:set(Row, Col, NewVal, DP),
    case Col of
        0 -> calculateMinimumHP(Dungeon, DP2, Row-1, Cols-1);
        _ -> calculateMinimumHP(Dungeon, DP2, Row, Col-1)
    end.