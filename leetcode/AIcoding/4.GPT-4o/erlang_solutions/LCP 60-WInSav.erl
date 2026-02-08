-module(solution).
-export([find_balls/1]).

find_balls(Grid) ->
    Rows = length(Grid),
    Columns = length(hd(Grid)),
    lists:map(fun({Ball, Col}) -> drop_ball(Grid, Rows, Col) end, lists:zip(lists:duplicate(Rows, 0), [0,1,2,3,4,5,6,7,8,9])).

drop_ball(Grid, Rows, Col) ->
    case drop(Grid, Rows, Col, 0) of
        {ok, _} -> 1;
        _ -> 0
    end.

drop(Grid, Rows, Col, Row) when Row < Rows ->
    case lists:nth(Col + 1, lists:nth(Row + 1, Grid)) of
        '.' -> drop(Grid, Rows, Col, Row + 1);
        '|' -> {error, blocked};
        _ -> {ok, Row}
    end;
drop(_, _, _, _) -> {error, out_of_bounds}.