-module(solution).
-export([closedIsland/1]).

closedIsland(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    Grid2 = lists:map(fun(Row) -> lists:map(fun(X) -> if X == 1 -> -1; true -> X end end, Row) end, Grid),
    lists:foldl(fun(X, Acc) -> Acc + dfs(Grid2, X, 0, Rows, Cols) end, 0, lists:seq(0, Rows - 1)).

dfs(Grid, {R, C}, Visited, Rows, Cols) ->
    if
        R < 0 orelse R >= Rows orelse C < 0 orelse C >= Cols -> 
            1;
        lists:nth(C + 1, lists:nth(R + 1, Grid)) == -1 -> 
            1;
        true -> 
            Grid2 = lists:update_element(C + 1, lists:update_element(R + 1, Grid, -1), -1),
            Visited2 = Visited + 1,
            dfs(Grid2, {R - 1, C}, Visited2, Rows, Cols) + 
            dfs(Grid2, {R + 1, C}, Visited2, Rows, Cols) + 
            dfs(Grid2, {R, C - 1}, Visited2, Rows, Cols) + 
            dfs(Grid2, {R, C + 1}, Visited2, Rows, Cols)
    end.