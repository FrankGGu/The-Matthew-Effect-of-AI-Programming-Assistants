-module(solution).
-export([is_possible_to_cut_path/1]).

is_possible_to_cut_path(Grid) ->
    case Grid of
        [] -> false;
        _ ->
            Rows = length(Grid),
            Cols = length(hd(Grid)),
            case dfs(0, 0, Rows, Cols, Grid) of
                false -> false;
                true ->
                    Grid1 = set_path(0, 0, Rows, Cols, Grid),
                    not dfs(0, 0, Rows, Cols, Grid1)
            end
    end.

dfs(R, C, Rows, Cols, Grid) ->
    if
        R =:= Rows - 1 andalso C =:= Cols - 1 -> true;
        R >= Rows orelse C >= Cols -> false;
        true ->
            case lists:nth(C + 1, lists:nth(R + 1, Grid)) of
                0 -> false;
                1 ->
                    (dfs(R + 1, C, Rows, Cols, Grid) orelse dfs(R, C + 1, Rows, Cols, Grid))
            end
    end.

set_path(R, C, Rows, Cols, Grid) ->
    if
        R =:= Rows - 1 andalso C =:= Cols - 1 -> Grid;
        R >= Rows orelse C >= Cols -> Grid;
        true ->
            case lists:nth(C + 1, lists:nth(R + 1, Grid)) of
                0 -> Grid;
                1 ->
                    Grid1 = set_path(R + 1, C, Rows, Cols, Grid),
                    Grid2 = set_path(R, C + 1, Rows, Cols, Grid1),
                    NewRow = setelement(C + 1, lists:nth(R + 1, Grid2), 0),
                    setelement(R + 1, Grid2, NewRow)
            end
    end.