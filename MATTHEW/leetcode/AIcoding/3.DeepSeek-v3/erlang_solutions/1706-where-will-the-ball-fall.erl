-spec find_ball(grid :: [[integer()]]) -> [integer()].
find_ball(Grid) ->
    M = length(Grid),
    N = length(hd(Grid)),
    lists:map(fun(Col) -> simulate(0, Col, Grid, M, N) end, lists:seq(0, N - 1)).

simulate(Row, Col, Grid, M, N) when Row =:= M -> Col;
simulate(Row, Col, Grid, M, N) ->
    case lists:nth(Col + 1, lists:nth(Row + 1, Grid)) of
        1 ->
            if
                Col + 1 < N andalso lists:nth(Col + 2, lists:nth(Row + 1, Grid)) =:= 1 ->
                    simulate(Row + 1, Col + 1, Grid, M, N);
                true -> -1
            end;
        -1 ->
            if
                Col - 1 >= 0 andalso lists:nth(Col, lists:nth(Row + 1, Grid)) =:= -1 ->
                    simulate(Row + 1, Col - 1, Grid, M, N);
                true -> -1
            end
    end.