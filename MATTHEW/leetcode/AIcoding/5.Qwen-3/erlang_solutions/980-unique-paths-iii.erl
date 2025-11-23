-module(unique_paths_iii).
-export([uniquePathsIII/1]).

uniquePathsIII(Grid) ->
    {Rows, Cols} = {length(Grid), length(hd(Grid))},
    Start = find_start(Grid),
    {X, Y} = Start,
    Count = 0,
    Total = (Rows * Cols) - 1,
    dfs(Grid, X, Y, 0, Total, 0).

find_start(Grid) ->
    find_start(Grid, 0, 0).

find_start([], _, _) -> {0, 0};
find_start([Row | Rest], X, Y) ->
    case lists:keymember(1, 1, Row) of
        true ->
            {X, Y};
        false ->
            find_start(Rest, X + 1, 0)
    end.

dfs(Grid, X, Y, Visited, Total, Count) ->
    case is_valid(Grid, X, Y) of
        true ->
            NewVisited = Visited bor (1 bsl (X * length(hd(Grid)) + Y)),
            if
                NewVisited == Total ->
                    Count + 1;
                true ->
                    dfs_up(Grid, X, Y, NewVisited, Total, Count)
            end;
        false ->
            Count
    end.

dfs_up(Grid, X, Y, Visited, Total, Count) ->
    dfs_right(Grid, X, Y, Visited, Total, Count).

dfs_right(Grid, X, Y, Visited, Total, Count) ->
    dfs_down(Grid, X, Y, Visited, Total, Count).

dfs_down(Grid, X, Y, Visited, Total, Count) ->
    dfs_left(Grid, X, Y, Visited, Total, Count).

dfs_left(Grid, X, Y, Visited, Total, Count) ->
    case X > 0 of
        true ->
            dfs(Grid, X - 1, Y, Visited, Total, Count);
        false ->
            Count
    end.

is_valid(Grid, X, Y) ->
    Row = lists:nth(X + 1, Grid),
    Val = lists:nth(Y + 1, Row),
    Val /= -1.