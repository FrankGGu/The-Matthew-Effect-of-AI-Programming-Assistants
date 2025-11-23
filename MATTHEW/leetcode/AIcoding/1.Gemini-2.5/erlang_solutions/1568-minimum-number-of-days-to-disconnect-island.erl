-module(solution).
-export([minDays/1]).

minDays(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),

    case count_islands(Grid, Rows, Cols) of
        1 ->
            case try_1_day(Grid, Rows, Cols) of
                1 -> 1;
                _ -> 2
            end;
        _ ->
            0
    end.

count_islands(Grid, Rows, Cols) ->
    Visited = array:new([{size, Rows * Cols}, {fixed, true}, {default, false}]),
    count_islands_loop(Grid, Rows, Cols, 0, 0, Visited, 0).

count_islands_loop(Grid, Rows, Cols, R, C, Visited, IslandCount) when R == Rows ->
    IslandCount;
count_islands_loop(Grid, Rows, Cols, R, C, Visited, IslandCount) when C == Cols ->
    count_islands_loop(Grid, Rows, Cols, R + 1, 0, Visited, IslandCount);
count_islands_loop(Grid, Rows, Cols, R, C, Visited, IslandCount) ->
    Index = R * Cols + C,
    case {get_cell(Grid, R, C), array:get(Index, Visited)} of
        {1, false} ->
            NewVisited = dfs_visit(Grid, Rows, Cols, R, C, Visited),
            count_islands_loop(Grid, Rows, Cols, R, C + 1, NewVisited, IslandCount + 1);
        _ ->
            count_islands_loop(Grid, Rows, Cols, R, C + 1, Visited, IslandCount)
    end.

dfs_visit(Grid, Rows, Cols, R, C, Visited) ->
    dfs_visit_recursive(Grid, Rows, Cols, R, C, Visited).

dfs_visit_recursive(Grid, Rows, Cols, R, C, Visited) ->
    Index = R * Cols + C,
    case {is_valid(R, C, Rows, Cols), get_cell(Grid, R, C), array:get(Index, Visited)} of
        {true, 1, false} ->
            NewVisited = array:set(Index, true, Visited),
            VisitedAfterDown = dfs_visit_recursive(Grid, Rows, Cols, R + 1, C, NewVisited),
            VisitedAfterUp = dfs_visit_recursive(Grid, Rows, Cols, R - 1, C, VisitedAfterDown),
            VisitedAfterRight = dfs_visit_recursive(Grid, Rows, Cols, R, C + 1, VisitedAfterUp),
            dfs_visit_recursive(Grid, Rows, Cols, R, C - 1, VisitedAfterRight);
        _ ->
            Visited
    end.

get_cell(Grid, R, C) ->
    lists:nth(C + 1, lists:nth(R + 1, Grid)).

is_valid(R, C, Rows, Cols) ->
    R >= 0 and R < Rows and C >= 0 and C < Cols.

try_1_day(Grid, Rows, Cols) ->
    try_1_day_loop(Grid, Rows, Cols, 0, 0).

try_1_day_loop(Grid, Rows, Cols, R, C) when R == Rows ->
    -1;
try_1_day_loop(Grid, Rows, Cols, R, C) when C == Cols ->
    try_1_day_loop(Grid, Rows, Cols, R + 1, 0);
try_1_day_loop(Grid, Rows, Cols, R, C) ->
    case get_cell(Grid, R, C) of
        1 ->
            Row = lists:nth(R + 1, Grid),
            NewRow = lists:replace_at(C + 1, 0, Row),
            ModifiedGrid = lists:replace_at(R + 1, NewRow, Grid),

            case count_islands(ModifiedGrid, Rows, Cols) of
                1 ->
                    try_1_day_loop(Grid, Rows, Cols, R, C + 1);
                _ ->
                    1
            end;
        0 ->
            try_1_day_loop(Grid, Rows, Cols, R, C + 1)
    end.