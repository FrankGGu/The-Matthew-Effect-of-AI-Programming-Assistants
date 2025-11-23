-module(number_of_enclaves).
-export([num_enclaves/1]).

num_enclaves(Grid) ->
    Rows = length(Grid),
    if Rows == 0 -> 0;
       true ->
            Cols = length(hd(Grid)),
            Visited = array:new({0, Rows-1}, {default, array:new({0, Cols-1}, {default, false})}),
            do_dfs(Grid, Visited, Rows, Cols)
    end.

do_dfs(Grid, Visited, Rows, Cols) ->
    I = 0,
    J = 0,
    do_dfs_loop(Grid, Visited, Rows, Cols, I, J, 0).

do_dfs_loop(Grid, Visited, Rows, Cols, I, J, Count) ->
    if
        I >= Rows -> Count;
        true ->
            if
                J >= Cols ->
                    do_dfs_loop(Grid, Visited, Rows, Cols, I+1, 0, Count);
                true ->
                    Cell = lists:nth(I+1, Grid),
                    Value = lists:nth(J+1, Cell),
                    case Value of
                        1 ->
                            case array:get({I, J}, Visited) of
                                false ->
                                    NewVisited = array:set({I, J}, true, Visited),
                                    NewCount = dfs(Grid, NewVisited, I, J, Rows, Cols, 0),
                                    do_dfs_loop(Grid, NewVisited, Rows, Cols, I, J+1, Count + NewCount);
                                _ ->
                                    do_dfs_loop(Grid, Visited, Rows, Cols, I, J+1, Count)
                            end;
                        _ ->
                            do_dfs_loop(Grid, Visited, Rows, Cols, I, J+1, Count)
                    end
            end
    end.

dfs(Grid, Visited, I, J, Rows, Cols, Count) ->
    case array:get({I, J}, Visited) of
        true -> Count;
        _ ->
            NewVisited = array:set({I, J}, true, Visited),
            Count1 = count_cell(Grid, I, J, Rows, Cols),
            NewCount = Count + Count1,
            NextCount = dfs_neighbors(Grid, NewVisited, I, J, Rows, Cols, NewCount),
            NextCount
    end.

count_cell(Grid, I, J, Rows, Cols) ->
    if
        I < 0 orelse I >= Rows orelse J < 0 orelse J >= Cols -> 0;
        true ->
            Cell = lists:nth(I+1, Grid),
            Value = lists:nth(J+1, Cell),
            if Value == 1 -> 1; true -> 0 end
    end.

dfs_neighbors(Grid, Visited, I, J, Rows, Cols, Count) ->
    Directions = [{-1, 0}, {1, 0}, {0, -1}, {0, 1}],
    dfs_neighbors_loop(Grid, Visited, I, J, Rows, Cols, Directions, Count).

dfs_neighbors_loop(_, _, _, _, _, _, [], Count) -> Count;
dfs_neighbors_loop(Grid, Visited, I, J, Rows, Cols, [{DI, DJ} | Rest], Count) ->
    NI = I + DI,
    NJ = J + DJ,
    case count_cell(Grid, NI, NJ, Rows, Cols) of
        1 ->
            case array:get({NI, NJ}, Visited) of
                false ->
                    NewVisited = array:set({NI, NJ}, true, Visited),
                    NewCount = dfs(Grid, NewVisited, NI, NJ, Rows, Cols, 0),
                    dfs_neighbors_loop(Grid, NewVisited, I, J, Rows, Cols, Rest, Count + NewCount);
                _ ->
                    dfs_neighbors_loop(Grid, Visited, I, J, Rows, Cols, Rest, Count)
            end;
        _ ->
            dfs_neighbors_loop(Grid, Visited, I, J, Rows, Cols, Rest, Count)
    end.