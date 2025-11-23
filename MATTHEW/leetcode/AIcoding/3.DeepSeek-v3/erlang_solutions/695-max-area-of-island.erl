-spec max_area_of_island(Grid :: [[integer()]]) -> integer().
max_area_of_island(Grid) ->
    Rows = length(Grid),
    case Rows of
        0 -> 0;
        _ ->
            Cols = length(hd(Grid)),
            MaxArea = lists:foldl(
                fun(I, Acc) ->
                    lists:foldl(
                        fun(J, Acc1) ->
                            case lists:nth(J + 1, lists:nth(I + 1, Grid)) of
                                1 ->
                                    Area = dfs(Grid, I, J, Rows, Cols),
                                    max(Acc1, Area);
                                _ ->
                                    Acc1
                            end
                        end,
                        Acc,
                        lists:seq(0, Cols - 1)
                end,
                0,
                lists:seq(0, Rows - 1)),
            MaxArea
    end.

dfs(Grid, I, J, Rows, Cols) ->
    if
        I < 0; I >= Rows; J < 0; J >= Cols -> 0;
        true ->
            Row = lists:nth(I + 1, Grid),
            case lists:nth(J + 1, Row) of
                1 ->
                    NewRow = setnth(J + 1, Row, 0),
                    NewGrid = setnth(I + 1, Grid, NewRow),
                    1 + dfs(NewGrid, I + 1, J, Rows, Cols) + dfs(NewGrid, I - 1, J, Rows, Cols) + dfs(NewGrid, I, J + 1, Rows, Cols) + dfs(NewGrid, I, J - 1, Rows, Cols);
                _ -> 0
            end
    end.

setnth(1, [_|T], X) -> [X|T];
setnth(N, [H|T], X) -> [H|setnth(N - 1, T, X)].