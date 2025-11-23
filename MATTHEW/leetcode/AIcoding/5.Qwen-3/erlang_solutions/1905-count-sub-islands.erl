-module(count_sub_islands).
-export([count_sub_islands/2]).

count_sub_islands(Grid1, Grid2) ->
    Rows = length(Grid1),
    Cols = length(hd(Grid1)),
    Count = 0,
    count_sub_islands(Grid1, Grid2, 0, 0, Rows, Cols, Count).

count_sub_islands(_, _, R, C, Rows, Cols, Acc) when R >= Rows ->
    Acc;
count_sub_islands(Grid1, Grid2, R, C, Rows, Cols, Acc) when C >= Cols ->
    count_sub_islands(Grid1, Grid2, R + 1, 0, Rows, Cols, Acc);
count_sub_islands(Grid1, Grid2, R, C, Rows, Cols, Acc) ->
    case grid_val(Grid1, R, C) of
        1 ->
            case grid_val(Grid2, R, C) of
                1 ->
                    IsSub = is_sub_island(Grid1, Grid2, R, C, Rows, Cols),
                    count_sub_islands(Grid1, Grid2, R, C + 1, Rows, Cols, Acc + (if IsSub -> 1; true -> 0 end));
                _ ->
                    count_sub_islands(Grid1, Grid2, R, C + 1, Rows, Cols, Acc)
            end;
        _ ->
            count_sub_islands(Grid1, Grid2, R, C + 1, Rows, Cols, Acc)
    end.

is_sub_island(Grid1, Grid2, R, C, Rows, Cols) ->
    IsSub = is_sub_island_dfs(Grid1, Grid2, R, C, Rows, Cols, true),
    IsSub.

is_sub_island_dfs(_, _, R, C, Rows, Cols, Acc) when R < 0 orelse R >= Rows orelse C < 0 orelse C >= Cols ->
    Acc;
is_sub_island_dfs(Grid1, Grid2, R, C, Rows, Cols, Acc) ->
    case grid_val(Grid1, R, C) of
        1 ->
            case grid_val(Grid2, R, C) of
                1 ->
                    is_sub_island_dfs(Grid1, Grid2, R + 1, C, Rows, Cols, is_sub_island_dfs(Grid1, Grid2, R - 1, C, Rows, Cols, is_sub_island_dfs(Grid1, Grid2, R, C + 1, Rows, Cols, is_sub_island_dfs(Grid1, Grid2, R, C - 1, Rows, Cols, Acc))));
                _ ->
                    false
            end;
        _ ->
            Acc
    end.

grid_val(Grid, R, C) ->
    lists:nth(R + 1, Grid, []) -- [0] ++ [lists:nth(C + 1, lists:nth(R + 1, Grid, []))].