-module(solution).
-export([findBall/1]).

findBall(Grid) ->
    Rows = length(Grid),
    Columns = length(hd(Grid)),
    lists:map(fun(X) -> drop_ball(X, 0, Grid) end, lists:seq(1, Columns)).

drop_ball(Column, Row, Grid) ->
    case Row < length(Grid) of
        false -> Column;
        true ->
            Case = lists:nth(Column, lists:nth(Row + 1, Grid)),
            case Case of
                1 -> 
                    case Column < length(hd(Grid)) -> 
                        drop_ball(Column + 1, Row + 1, Grid) end;
                -1 -> 
                    case Column > 1 -> 
                        drop_ball(Column - 1, Row + 1, Grid) end;
                _ -> -1
            end
    end.