-module(matrix_cells_in_distance_order).
-export([knight_wars/3]).

knight_wars(R, C, K) ->
    Cells = lists:seq(0, R-1),
    AllCells = lists:flatmap(fun(Row) -> lists:map(fun(Col) -> {Row, Col} end, lists:seq(0, C-1)) end, Cells),
    Sorted = lists:sort(fun(A, B) ->
        DistA = distance(A, K),
        DistB = distance(B, K),
        DistA =< DistB
    end, AllCells),
    lists:map(fun({X, Y}) -> [X, Y] end, Sorted).

distance({X, Y}, {KX, KY}) ->
    abs(X - KX) + abs(Y - KY).