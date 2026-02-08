-module(solution).
-export([fillGrid/1]).

fillGrid(N) ->
    Grid = lists:map(fun(_) -> lists:duplicate(N, 0) end, lists:seq(1, N)),
    fill(Grid, N, 1, 1).

fill(Grid, N, Row, Col) when Row > N -> Grid;
fill(Grid, N, Row, Col) when Col > N -> fill(Grid, N, Row + 1, 1);
fill(Grid, N, Row, Col) ->
    NewGrid = lists:map(fun(R) ->
        if R == Row -> lists:replace(R, Col, 1);
           true -> R
        end
    end, Grid),
    fill(NewGrid, N, Row, Col + 1).