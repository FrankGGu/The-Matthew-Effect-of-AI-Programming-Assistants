-module(solution).
-export([count_increasing_paths/1]).

count_increasing_paths(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    Visited = lists:duplicate(Rows, lists:duplicate(Cols, false)),
    {Count, _} = count_paths(Grid, Visited, 0, 0, Rows, Cols),
    Count.

count_paths(_, _, Row, Col, Rows, Cols) when Row < 0; Row >= Rows; Col < 0; Col >= Cols ->
    {0, []};
count_paths(Grid, Visited, Row, Col, Rows, Cols) ->
    case lists:nth(Row + 1, lists:nth(Col + 1, Grid)) of
        Current ->
            Paths = lists:foldl(fun({DRow, DCol}, Acc) ->
                NewRow = Row + DRow,
                NewCol = Col + DCol,
                case get_value(Grid, NewRow, NewCol) of
                    Next when Next > Current ->
                        case lists:nth(NewRow + 1, lists:nth(NewCol + 1, Visited)) of
                            false ->
                                NewVisited = update_visited(Visited, NewRow, NewCol, true),
                                {Count, _} = count_paths(Grid, NewVisited, NewRow, NewCol, Rows, Cols),
                                Acc + Count;
                            _ -> Acc
                        end;
                    _ -> Acc
                end
            end, 0, directions()),
            {1 + Paths, Visited}
    end.

get_value(Grid, Row, Col) when Row < 0; Row >= length(Grid); Col < 0; Col >= length(hd(Grid)) -> 
    -1;
get_value(Grid, Row, Col) -> 
    lists:nth(Row + 1, lists:nth(Col + 1, Grid)).

update_visited(Visited, Row, Col, Value) ->
    lists:map(fun(RowList, R) -> 
        if R == Row then 
            lists:map(fun(VisitedValue, C) -> 
                if C == Col then Value else VisitedValue end 
            end, RowList) 
        else RowList 
        end, Visited).

directions() -> [{1, 0}, {0, 1}, {-1, 0}, {0, -1}].