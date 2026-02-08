-module(max_area_of_island).
-export([max_area_of_island/1]).

max_area_of_island(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    Visited = orddict:new(),
    max_area_of_island(Grid, Rows, Cols, Visited, 0).

max_area_of_island(Grid, Rows, Cols, Visited, MaxArea) ->
    max_area_of_island(Grid, Rows, Cols, Visited, 0, 0, MaxArea).

max_area_of_island(Grid, Rows, Cols, Visited, Row, Col, MaxArea) ->
    case Row >= Rows of
        true ->
            MaxArea;
        false ->
            case Col >= Cols of
                true ->
                    max_area_of_island(Grid, Rows, Cols, Visited, Row + 1, 0, MaxArea);
                false ->
                    case orddict:is_key({Row, Col}, Visited) of
                        true ->
                            max_area_of_island(Grid, Rows, Cols, Visited, Row, Col + 1, MaxArea);
                        false ->
                            case lists:nth(Row + 1, Grid) of
                                L when is_list(L) ->
                                    case lists:nth(Col + 1, L) of
                                        1 ->
                                            Area = dfs(Grid, Rows, Cols, Visited, Row, Col, 0),
                                            NewMaxArea = max(MaxArea, Area),
                                            max_area_of_island(Grid, Rows, Cols, Visited, Row, Col + 1, NewMaxArea);
                                        0 ->
                                            max_area_of_island(Grid, Rows, Cols, Visited, Row, Col + 1, MaxArea);
                                    end;
                                _ ->
                                    max_area_of_island(Grid, Rows, Cols, Visited, Row, Col + 1, MaxArea)
                            end
                    end
            end
    end.

dfs(Grid, Rows, Cols, Visited, Row, Col, Area) ->
    case Row < 0 or Row >= Rows or Col < 0 or Col >= Cols of
        true ->
            0;
        false ->
            case orddict:is_key({Row, Col}, Visited) of
                true ->
                    0;
                false ->
                    case lists:nth(Row + 1, Grid) of
                        L when is_list(L) ->
                            case lists:nth(Col + 1, L) of
                                1 ->
                                    NewVisited = orddict:store({Row, Col}, true, Visited),
                                    1 + dfs(Grid, Rows, Cols, NewVisited, Row + 1, Col, Area) +
                                        dfs(Grid, Rows, Cols, NewVisited, Row - 1, Col, Area) +
                                        dfs(Grid, Rows, Cols, NewVisited, Row, Col + 1, Area) +
                                        dfs(Grid, Rows, Cols, NewVisited, Row, Col - 1, Area);
                                0 ->
                                    0
                            end;
                        _ ->
                            0
                    end
            end
    end.

max(A, B) ->
    if A > B -> A; true -> B end.