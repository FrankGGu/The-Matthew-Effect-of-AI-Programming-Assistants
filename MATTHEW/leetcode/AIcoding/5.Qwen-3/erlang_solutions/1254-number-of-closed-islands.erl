-module(number_of_closed_islands).
-export([closedIslandCount/1]).

closedIslandCount(Grid) ->
    Rows = length(Grid),
    if
        Rows == 0 -> 0;
        true ->
            Cols = length(hd(Grid)),
            Visited = array:new({1, Rows}, {default, array:new({1, Cols}, {default, false})}),
            Count = 0,
            loop_rows(0, Rows - 1, Grid, Visited, Count)
    end.

loop_rows(Row, MaxRow, Grid, Visited, Count) when Row > MaxRow ->
    Count;
loop_rows(Row, MaxRow, Grid, Visited, Count) ->
    loop_cols(0, length(hd(Grid)) - 1, Row, Grid, Visited, Count).

loop_cols(Col, MaxCol, Row, Grid, Visited, Count) when Col > MaxCol ->
    loop_rows(Row + 1, MaxRow, Grid, Visited, Count);
loop_cols(Col, MaxCol, Row, Grid, Visited, Count) ->
    case array:get({Row + 1, Col + 1}, Visited) of
        true ->
            loop_cols(Col + 1, MaxCol, Row, Grid, Visited, Count);
        false ->
            case get_cell(Grid, Row, Col) of
                0 ->
                    NewVisited = array:set({Row + 1, Col + 1}, true, Visited),
                    IsClosed = dfs(Grid, Row, Col, NewVisited),
                    loop_cols(Col + 1, MaxCol, Row, Grid, NewVisited, Count + (if IsClosed -> 1; true -> 0 end));
                _ ->
                    loop_cols(Col + 1, MaxCol, Row, Grid, Visited, Count)
            end
    end.

get_cell(Grid, Row, Col) ->
    lists:nth(Row + 1, Grid),
    lists:nth(Col + 1, lists:nth(Row + 1, Grid)).

dfs(Grid, Row, Col, Visited) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    case is_boundary(Row, Col, Rows, Cols) of
        true ->
            false;
        false ->
            case get_cell(Grid, Row, Col) of
                0 ->
                    NewVisited = array:set({Row + 1, Col + 1}, true, Visited),
                    Dirs = [{-1, 0}, {1, 0}, {0, -1}, {0, 1}],
                    Result = lists:all(fun({Dr, Dc}) ->
                                            dfs(Grid, Row + Dr, Col + Dc, NewVisited)
                                        end, Dirs),
                    Result;
                _ ->
                    true
            end
    end.

is_boundary(Row, Col, Rows, Cols) ->
    Row == 0 orelse Row == Rows - 1 orelse Col == 0 orelse Col == Cols - 1.