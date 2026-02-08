-module(solution).
-export([maxPoints/2]).

maxPoints(Grid, Queries) ->
    MaxPoints = lists:map(fun({X, Y}) -> get_points(Grid, X, Y) end, Queries),
    MaxPoints.

get_points(Grid, X, Y) ->
    case lists:reverse(grid_row(Grid, Y)) of
        [] -> 0;
        Row -> 
            lists:sum(lists:sublist(Row, 1, X))
    end.

grid_row(Grid, Y) ->
    case lists:nth(Y + 1, Grid) of
        Row -> Row;
        _ -> []
    end.