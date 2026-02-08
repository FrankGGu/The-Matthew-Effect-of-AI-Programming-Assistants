-module(solution).
-export([num_increasing_paths/1]).

num_increasing_paths(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    DP = array:new({size, Rows * Cols}, {default, 0}),
    Visited = array:new({size, Rows * Cols}, {default, false}),
    Count = 0,
    lists:foreach(fun(Row) -> 
        lists:foreach(fun(Col) -> 
            Count = count_paths(Grid, Row, Col, DP, Visited, Rows, Cols)
        end, lists:seq(0, Cols - 1))
    end, lists:seq(0, Rows - 1)),
    Count.

count_paths(Grid, Row, Col, DP, Visited, Rows, Cols) ->
    Index = Row * Cols + Col,
    case array:get(Index, Visited) of
        true ->
            array:get(Index, DP);
        false ->
            array:set(Index, true, Visited),
            Val = lists:nth(Row + 1, Grid),
            Val = lists:nth(Col + 1, Val),
            Total = 1,
            Directions = [{-1, 0}, {1, 0}, {0, -1}, {0, 1}],
            lists:foreach(fun({DR, DC}) ->
                NewRow = Row + DR,
                NewCol = Col + DC,
                if
                    NewRow >= 0, NewRow < Rows, NewCol >= 0, NewCol < Cols ->
                        NextVal = lists:nth(NewRow + 1, Grid),
                        NextVal = lists:nth(NewCol + 1, NextVal),
                        if
                            NextVal < Val ->
                                Total = Total + count_paths(Grid, NewRow, NewCol, DP, Visited, Rows, Cols);
                            true ->
                                ok
                        end;
                    true ->
                        ok
                end
            end, Directions),
            array:set(Index, Total, DP),
            Total
    end.