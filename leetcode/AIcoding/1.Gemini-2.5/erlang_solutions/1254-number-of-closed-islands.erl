-module(solution).
-export([closedIsland/1]).

closedIsland(Grid) ->
    R = length(Grid),
    C = length(hd(Grid)),

    InitialState = {Grid, gb_sets:empty(), 0},

    FinalState = iterate_grid(InitialState, R, C, 0, 0),

    element(3, FinalState).

iterate_grid({Grid, Visited, Count}, R, C, Row, Col) ->
    case {Row, Col} of
        {R, _} ->
            {Grid, Visited, Count};
        {_, C} ->
            iterate_grid({Grid, Visited, Count}, R, C, Row + 1, 0);
        _ ->
            CurrentCell = get_cell(Grid, Row, Col),

            if CurrentCell == 0 and not gb_sets:is_element({Row, Col}, Visited) ->
                {NewVisited, TouchesBoundary} = dfs(Grid, R, C, Row, Col, Visited),

                NewCount = if TouchesBoundary -> Count;
                                  true -> Count + 1
                           end,

                iterate_grid({Grid, NewVisited, NewCount}, R, C, Row, Col + 1);
            true ->
                iterate_grid({Grid, Visited, Count}, R, C, Row, Col + 1)
            end
    end.

dfs(Grid, R, C, Row, Col, Visited) ->
    if Row < 0 or Row >= R or Col < 0 or Col >= C ->
        {Visited, true};
    else
        if gb_sets:is_element({Row, Col}, Visited) ->
            {Visited, false};
        else
            CurrentCell = get_cell(Grid, Row, Col),
            if CurrentCell == 1 ->
                {Visited, false};
            else
                Visited1 = gb_sets:add({Row, Col}, Visited),

                {Visited2, TouchesUp}    = dfs(Grid, R, C, Row - 1, Col, Visited1),
                {Visited3, TouchesDown}  = dfs(Grid, R, C, Row + 1, Col, Visited2),
                {Visited4, TouchesLeft}  = dfs(Grid, R, C, Row, Col - 1, Visited3),
                {Visited5, TouchesRight} = dfs(Grid, R, C, Row, Col + 1, Visited4),

                {Visited5, TouchesUp or TouchesDown or TouchesLeft or TouchesRight}
            end
        end
    end.

get_cell(Grid, Row, Col) ->
    lists:nth(Col + 1, lists:nth(Row + 1, Grid)).