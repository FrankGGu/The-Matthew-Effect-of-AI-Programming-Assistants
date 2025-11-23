-module(grid_illumination).
-export([grid_illumination/2]).

grid_illumination(Points, Queries) ->
    Rows = maps:new(),
    Cols = maps:new(),
    Diag1 = maps:new(),
    Diag2 = maps:new(),
    Pairs = lists:foldl(fun({X,Y}, Acc) ->
        Row = maps:get(X, Acc#rows, 0),
        Col = maps:get(Y, Acc#cols, 0),
        D1 = maps:get(X-Y, Acc#diag1, 0),
        D2 = maps:get(X+Y, Acc#diag2, 0),
        #{
            rows => maps:put(X, Row + 1, Acc#rows),
            cols => maps:put(Y, Col + 1, Acc#cols),
            diag1 => maps:put(X-Y, D1 + 1, Acc#diag1),
            diag2 => maps:put(X+Y, D2 + 1, Acc#diag2)
        }
    end, #{rows => Rows, cols => Cols, diag1 => Diag1, diag2 => Diag2}, Points),
    lists:map(fun({X,Y}) ->
        case (maps:get(X, Pairs#rows, 0) > 0) or (maps:get(Y, Pairs#cols, 0) > 0) or (maps:get(X-Y, Pairs#diag1, 0) > 0) or (maps:get(X+Y, Pairs#diag2, 0) > 0) of
            true -> 1;
            false -> 0
        end
    end, Queries).