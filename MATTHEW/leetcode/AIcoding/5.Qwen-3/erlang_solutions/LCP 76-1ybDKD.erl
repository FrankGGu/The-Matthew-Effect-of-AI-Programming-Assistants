-module(magic_board).
-export([min_cost/1]).

min_cost(Board) ->
    Rows = length(Board),
    Cols = length(hd(Board)),
    DP = array:new({0, Rows-1}, {0, Cols-1}, 0),
    min_cost(Board, DP, 0, 0).

min_cost(_, _, Row, Col) when Row >= length(Board) -> 0;
min_cost(_, _, Row, Col) when Col >= length(hd(Board)) -> 0;
min_cost(Board, DP, Row, Col) ->
    case array:get(DP, Row, Col) of
        undefined ->
            Cost = lists:nth(Row+1, Board) -- lists:nth(Col+1, hd(Board)),
            Down = min_cost(Board, DP, Row+1, Col),
            Right = min_cost(Board, DP, Row, Col+1),
            Total = Cost + min(Down, Right),
            array:set(DP, Row, Col, Total),
            Total;
        Value -> Value
    end.