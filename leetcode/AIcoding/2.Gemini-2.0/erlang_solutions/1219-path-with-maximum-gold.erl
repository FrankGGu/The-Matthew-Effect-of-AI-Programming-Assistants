-module(path_with_maximum_gold).
-export([get_maximum_gold/1]).

get_maximum_gold(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    MaxGold = 0,
    for(Row <- 0 to Rows - 1),
        for(Col <- 0 to Cols - 1),
            case lists:nth(Row + 1, Grid) of
                RowList ->
                    case lists:nth(Col + 1, RowList) of
                        0 ->
                            ok;
                        Gold ->
                            MaxGold1 = dfs(Grid, Row, Col, Gold, Rows, Cols, []),
                            MaxGold = max(MaxGold, MaxGold1)
                    end
            end,
        ok
    end,
    MaxGold.

dfs(Grid, Row, Col, CurrentGold, Rows, Cols, Visited) ->
    Neighbors = get_neighbors(Row, Col, Rows, Cols, Grid, Visited),
    case Neighbors of
        [] ->
            CurrentGold;
        _ ->
            MaxNeighborGold = lists:foldl(
                fun({NewRow, NewCol, Gold}, AccMax) ->
                    NewVisited = [{Row, Col} | Visited],
                    NewGold = dfs(Grid, NewRow, NewCol, CurrentGold + Gold, Rows, Cols, NewVisited),
                    max(AccMax, NewGold)
                end,
                0,
                Neighbors
            ),
            MaxNeighborGold
    end.

get_neighbors(Row, Col, Rows, Cols, Grid, Visited) ->
    Neighbors = [],
    Neighbors1 = case Row > 0 of
        true ->
            case is_visited({Row - 1, Col}, Visited) of
                false ->
                    case lists:nth(Row, Grid) of
                        RowList ->
                            case lists:nth(Col + 1, RowList) of
                                0 ->
                                    Neighbors;
                                Gold ->
                                    [{Row - 1, Col, Gold} | Neighbors]
                            end
                    end;
                true ->
                    Neighbors
            end;
        false ->
            Neighbors
    end,
    Neighbors2 = case Row < Rows - 1 of
        true ->
            case is_visited({Row + 1, Col}, Visited) of
                false ->
                    case lists:nth(Row + 2, Grid) of
                        RowList ->
                            case lists:nth(Col + 1, RowList) of
                                0 ->
                                    Neighbors1;
                                Gold ->
                                    [{Row + 1, Col, Gold} | Neighbors1]
                            end
                    end;
                true ->
                    Neighbors1
            end;
        false ->
            Neighbors1
    end,
    Neighbors3 = case Col > 0 of
        true ->
            case is_visited({Row, Col - 1}, Visited) of
                false ->
                    case lists:nth(Row + 1, Grid) of
                        RowList ->
                            case lists:nth(Col, RowList) of
                                0 ->
                                    Neighbors2;
                                Gold ->
                                    [{Row, Col - 1, Gold} | Neighbors2]
                            end
                    end;
                true ->
                    Neighbors2
            end;
        false ->
            Neighbors2
    end,
    Neighbors4 = case Col < Cols - 1 of
        true ->
            case is_visited({Row, Col + 1}, Visited) of
                false ->
                    case lists:nth(Row + 1, Grid) of
                        RowList ->
                            case lists:nth(Col + 2, RowList) of
                                0 ->
                                    Neighbors3;
                                Gold ->
                                    [{Row, Col + 1, Gold} | Neighbors3]
                            end
                    end;
                true ->
                    Neighbors3
            end;
        false ->
            Neighbors3
    end,
    Neighbors4.

is_visited({Row, Col}, Visited) ->
    lists:member({Row, Col}, Visited).