-module(min_days_to_disconnect_island).
-export([minDays/1]).

minDays(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    Islands = findIslands(Grid, Rows, Cols),
    case Islands of
        [] -> 0;
        _ -> 
            [Island | _] = Islands,
            findMinDays(Grid, Rows, Cols, Island)
    end.

findIslands(Grid, Rows, Cols) ->
    Islands = [],
    Visited = array:new({Rows, Cols}, {default, false}),
    findIslands(Grid, Rows, Cols, 0, 0, Visited, Islands).

findIslands(_, _, _, R, C, _, Islands) when R >= 0, C >= 0, R < 0, C < 0 -> Islands;
findIslands(Grid, Rows, Cols, R, C, Visited, Islands) when R >= Rows; C >= Cols ->
    findIslands(Grid, Rows, Cols, R + 1, 0, Visited, Islands);
findIslands(Grid, Rows, Cols, R, C, Visited, Islands) when C >= Cols ->
    findIslands(Grid, Rows, Cols, R + 1, 0, Visited, Islands);
findIslands(Grid, Rows, Cols, R, C, Visited, Islands) ->
    if
        array:get(Visited, {R, C}) == true -> findIslands(Grid, Rows, Cols, R, C + 1, Visited, Islands);
        hd(array:get(Grid, R)) == 0 -> findIslands(Grid, Rows, Cols, R, C + 1, Visited, Islands);
        true ->
            NewVisited = array:set(Visited, {R, C}, true),
            Isolated = dfs(Grid, Rows, Cols, R, C, NewVisited),
            NewIslands = [Isolated | Islands],
            findIslands(Grid, Rows, Cols, R, C + 1, NewVisited, NewIslands)
    end.

dfs(Grid, Rows, Cols, R, C, Visited) ->
    if
        R < 0; C < 0; R >= Rows; C >= Cols; array:get(Visited, {R, C}) == true; hd(array:get(Grid, R)) == 0 -> [];
        true ->
            NewVisited = array:set(Visited, {R, C}, true),
            Current = [{R, C}],
            Up = dfs(Grid, Rows, Cols, R - 1, C, NewVisited),
            Down = dfs(Grid, Rows, Cols, R + 1, C, NewVisited),
            Left = dfs(Grid, Rows, Cols, R, C - 1, NewVisited),
            Right = dfs(Grid, Rows, Cols, R, C + 1, NewVisited),
            lists:flatten([Current | [Up, Down, Left, Right]])
    end.

findMinDays(Grid, Rows, Cols, Island) ->
    Islands = lists:usort(Island),
    findMinDays(Grid, Rows, Cols, Islands, 0).

findMinDays(_, _, _, [], Min) -> Min;
findMinDays(Grid, Rows, Cols, [{R, C} | Rest], Min) ->
    GridCopy = copyGrid(Grid),
    array:set(GridCopy, {R, C}, 0),
    NewIslands = findIslands(GridCopy, Rows, Cols),
    case NewIslands of
        [] -> 1;
        _ -> findMinDays(Grid, Rows, Cols, Rest, min(Min, 1))
    end.

copyGrid(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    array:new({Rows, Cols}, {default, 0}).

array:get(Array, {R, C}) ->
    element(R + 1, Array),
    element(C + 1, element(R + 1, Array)).

array:set(Array, {R, C}, Value) ->
    Row = element(R + 1, Array),
    NewRow = setelement(C + 1, Row, Value),
    setelement(R + 1, Array, NewRow).