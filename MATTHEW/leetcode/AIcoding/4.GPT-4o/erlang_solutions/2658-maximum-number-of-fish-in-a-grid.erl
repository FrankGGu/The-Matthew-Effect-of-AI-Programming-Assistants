-module(solution).
-export([max_fish/1]).

max_fish(Grid) ->
    {Rows, Cols} = lists:foldl(fun(Row, {R, C}) -> {R + 1, max(C, length(Row))} end, {0, 0}, Grid),
    {Rows, Cols} = {element(1, Rows), element(2, Rows)},
    max_fish_helper(Grid, Rows, Cols, 0, 0, []).

max_fish_helper(_, Rows, Cols, R, C, Visited) when R < 0; R >= Rows; C < 0; C >= Cols; lists:member({R, C}, Visited) -> 
    0;
max_fish_helper(Grid, Rows, Cols, R, C, Visited) ->
    Fish = lists:nth(C + 1, lists:nth(R + 1, Grid)),
    if
        Fish > 0 ->
            NewVisited = [{R, C} | Visited],
            Fish + max_fish_helper(Grid, Rows, Cols, R + 1, C, NewVisited) +
            max_fish_helper(Grid, Rows, Cols, R - 1, C, NewVisited) +
            max_fish_helper(Grid, Rows, Cols, R, C + 1, NewVisited) +
            max_fish_helper(Grid, Rows, Cols, R, C - 1, NewVisited);
        true ->
            0
    end.