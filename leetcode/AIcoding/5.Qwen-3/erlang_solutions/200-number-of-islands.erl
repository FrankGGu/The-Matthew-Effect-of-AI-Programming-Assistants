-module(num_islands).
-export([num_islands/1]).

num_islands(Grid) ->
    Rows = length(Grid),
    if
        Rows == 0 -> 0;
        true ->
            Cols = length(hd(Grid)),
            count_islands(Grid, Rows, Cols, 0, 0)
    end.

count_islands(Grid, Rows, Cols, R, C) ->
    if
        R >= Rows -> 0;
        true ->
            if
                C >= Cols -> count_islands(Grid, Rows, Cols, R + 1, 0);
                true ->
                    case lists:nth(R + 1, Grid) of
                        Row when is_list(Row) ->
                            Cell = lists:nth(C + 1, Row),
                            if
                                Cell == $1 ->
                                    mark_island(Grid, Rows, Cols, R, C),
                                    count_islands(Grid, Rows, Cols, R, C + 1) + 1;
                                true ->
                                    count_islands(Grid, Rows, Cols, R, C + 1)
                            end
                    end
            end
    end.

mark_island(Grid, Rows, Cols, R, C) ->
    if
        R < 0; R >= Rows; C < 0; C >= Cols -> ok;
        true ->
            case lists:nth(R + 1, Grid) of
                Row when is_list(Row) ->
                    Cell = lists:nth(C + 1, Row),
                    if
                        Cell == $1 ->
                            NewRow = lists:sublist(Row, C) ++ [$0] ++ lists:nthtail(C + 1, Row),
                            NewGrid = lists:sublist(Grid, R) ++ [NewRow] ++ lists:nthtail(R + 1, Grid),
                            mark_island(NewGrid, Rows, Cols, R - 1, C),
                            mark_island(NewGrid, Rows, Cols, R + 1, C),
                            mark_island(NewGrid, Rows, Cols, R, C - 1),
                            mark_island(NewGrid, Rows, Cols, R, C + 1);
                        true -> ok
                    end
            end
    end.