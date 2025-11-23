-spec max_area_of_island(Grid :: [[integer()]]) -> integer().
max_area_of_island(Grid) ->
    Rows = length(Grid),
    case Rows of
        0 -> 0;
        _ ->
            Cols = length(hd(Grid)),
            Visited = sets:new(),
            lists:max([0 | [dfs(Grid, Rows, Cols, I, J, Visited) || I <- lists:seq(0, Rows - 1), J <- lists:seq(0, Cols - 1), lists:nth(I + 1, Grid) /= undefined, lists:nth(J + 1, lists:nth(I + 1, Grid)) == 1]])
    end.

dfs(Grid, Rows, Cols, I, J, Visited) ->
    case sets:is_element({I, J}, Visited) of
        true -> 0;
        false ->
            NewVisited = sets:add_element({I, J}, Visited),
            Directions = [{-1, 0}, {1, 0}, {0, -1}, {0, 1}],
            lists:foldl(fun({Di, Dj}, Acc) ->
                Ni = I + Di,
                Nj = J + Dj,
                if
                    Ni >= 0, Ni < Rows, Nj >= 0, Nj < Cols, lists:nth(Ni + 1, Grid) /= undefined, lists:nth(Nj + 1, lists:nth(Ni + 1, Grid)) == 1 ->
                        Acc + dfs(Grid, Rows, Cols, Ni, Nj, NewVisited);
                    true -> Acc
                end
            end, 1, Directions)
    end.