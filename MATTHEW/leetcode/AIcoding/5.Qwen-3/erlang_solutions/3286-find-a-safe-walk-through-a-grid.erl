-module(safe_walk).
-export([is_safe/2]).

is_safe(Grid, k) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    dfs(0, 0, 0, Grid, k, Rows, Cols).

dfs(R, C, Count, Grid, K, Rows, Cols) ->
    if
        R < 0; R >= Rows; C < 0; C >= Cols -> false;
        Grid#{}[R][C] == 1 -> false;
        Count >= K -> true;
        true ->
            NewCount = Count + 1,
            Up = dfs(R-1, C, NewCount, Grid, K, Rows, Cols),
            Down = dfs(R+1, C, NewCount, Grid, K, Rows, Cols),
            Left = dfs(R, C-1, NewCount, Grid, K, Rows, Cols),
            Right = dfs(R, C+1, NewCount, Grid, K, Rows, Cols),
            Up orelse Down orelse Left orelse Right
    end.