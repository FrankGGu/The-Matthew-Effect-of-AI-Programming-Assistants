-spec num_islands(Grid :: [[char()]]) -> integer().
num_islands(Grid) ->
    case Grid of
        [] -> 0;
        _ ->
            Rows = length(Grid),
            Cols = length(hd(Grid)),
            Visited = sets:new(),
            count_islands(Grid, Rows, Cols, Visited, 0, 0, 0)
    end.

count_islands(Grid, Rows, Cols, Visited, I, J, Count) ->
    if
        I >= Rows -> Count;
        J >= Cols -> count_islands(Grid, Rows, Cols, Visited, I + 1, 0, Count);
        true ->
            case is_land(Grid, I, J) andalso not sets:is_element({I, J}, Visited) of
                true ->
                    NewVisited = explore(Grid, Rows, Cols, Visited, I, J),
                    count_islands(Grid, Rows, Cols, NewVisited, I, J + 1, Count + 1);
                false ->
                    count_islands(Grid, Rows, Cols, Visited, I, J + 1, Count)
            end
    end.

explore(Grid, Rows, Cols, Visited, I, J) ->
    case I >= 0 andalso I < Rows andalso J >= 0 andalso J < Cols andalso is_land(Grid, I, J) andalso not sets:is_element({I, J}, Visited) of
        true ->
            NewVisited = sets:add_element({I, J}, Visited),
            NewVisited1 = explore(Grid, Rows, Cols, NewVisited, I + 1, J),
            NewVisited2 = explore(Grid, Rows, Cols, NewVisited1, I - 1, J),
            NewVisited3 = explore(Grid, Rows, Cols, NewVisited2, I, J + 1),
            explore(Grid, Rows, Cols, NewVisited3, I, J - 1);
        false ->
            Visited
    end.

is_land(Grid, I, J) ->
    lists:nth(J + 1, lists:nth(I + 1, Grid)) == $1.