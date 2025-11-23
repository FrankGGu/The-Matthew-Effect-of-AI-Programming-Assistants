-module(solution).
-export([crossTheStreet/2]).

crossTheStreet(Grid, K) ->
    simulate(Grid, K).

simulate(Grid, 0) -> Grid;
simulate(Grid, K) ->
    NextGrid = step(Grid),
    simulate(NextGrid, K - 1).

step(Grid) ->
    lists:map(fun(Row) -> step_row(Row) end, Grid).

step_row(Row) ->
    PrevRow = [0 | lists:droplast(Row)],
    Zipped = lists:zip(PrevRow, Row),
    lists:map(fun({PrevVal, CurrentVal}) ->
        if
            PrevVal == 1 andalso CurrentVal == 0 -> 1;
            true -> 0
        end
    end, Zipped).