-module(max_area_of_island).
-export([maxAreaOfIsland/1]).

maxAreaOfIsland(Grid) ->
    max_area(Grid, 0, 0, 0, length(Grid), length(hd(Grid))).

max_area(_, _, Y, Max, _, _) when Y >= length(Grid) -> Max;
max_area(Grid, X, Y, Max, Rows, Cols) when X >= Cols ->
    max_area(Grid, 0, Y + 1, Max, Rows, Cols);
max_area(Grid, X, Y, Max, Rows, Cols) ->
    case grid_value(Grid, X, Y) of
        1 ->
            Area = dfs(Grid, X, Y, 0, Rows, Cols),
            max_area(Grid, X + 1, Y, max(Max, Area), Rows, Cols);
        _ ->
            max_area(Grid, X + 1, Y, Max, Rows, Cols)
    end.

grid_value(Grid, X, Y) ->
    lists:nth(Y + 1, Grid, []) ! X + 1.

dfs(_, _, _, Acc, _, _) when Acc == -1 -> Acc;
dfs(Grid, X, Y, Acc, Rows, Cols) ->
    case grid_value(Grid, X, Y) of
        1 ->
            NewAcc = Acc + 1,
            set_grid_value(Grid, X, Y, 0),
            Up = dfs(Grid, X, Y - 1, NewAcc, Rows, Cols),
            Down = dfs(Grid, X, Y + 1, Up, Rows, Cols),
            Left = dfs(Grid, X - 1, Y, Down, Rows, Cols),
            Right = dfs(Grid, X + 1, Y, Left, Rows, Cols),
            Right;
        _ ->
            Acc
    end.

set_grid_value(Grid, X, Y, Val) ->
    List = lists:nth(Y + 1, Grid),
    UpdatedList = lists:sublist(List, X) ++ [Val] ++ lists:sublist(List, X + 1, length(List) - X - 1),
    lists:substitute(Y + 1, UpdatedList, Grid).