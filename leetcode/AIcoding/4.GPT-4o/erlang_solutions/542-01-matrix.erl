-module(solution).
-export([updateMatrix/1]).

updateMatrix(Matrix) ->
    Rows = length(Matrix),
    Cols = length(hd(Matrix)),
    Distances = lists:map(fun(_) -> lists:duplicate(Cols, infinity) end, Matrix),
    Queue = [{I, J} || I <- lists:seq(0, Rows - 1), J <- lists:seq(0, Cols - 1), lists:nth(J + 1, lists:nth(I + 1, Matrix)) == 0],
    Distances1 = lists:map(fun(Row) -> lists:map(fun(_) -> 0 end, Row) end, Matrix),
    lists:foldl(fun({I, J}, Acc) ->
        Acc1 = lists:map(fun(Row) -> lists:map(fun(X) -> if X == infinity -> X; true -> X + 1 end end, Row) end, Acc),
        Acc2 = update_adjacent(Acc1, I, J, Rows, Cols),
        Acc2
    end, Distances1, Queue).

update_adjacent(Distances, I, J, Rows, Cols) ->
    Directions = [{-1, 0}, {1, 0}, {0, -1}, {0, 1}],
    lists:foldl(fun({DI, DJ}, Acc) ->
        I2 = I + DI,
        J2 = J + DJ,
        if I2 >= 0, I2 < Rows, J2 >= 0, J2 < Cols ->
            if lists:nth(J2 + 1, lists:nth(I2 + 1, Acc)) > lists:nth(J + 1, lists:nth(I + 1, Acc)) + 1 ->
                Acc1 = lists:map(fun(Row, Index) ->
                    if Index == I2 ->
                        lists:map(fun(X, JIndex) -> if JIndex == J2 -> lists:nth(J + 1, lists:nth(I + 1, Acc)) + 1; true -> X end end, Row);
                    true -> Row
                    end, Acc)
                end,
                Acc1;
            true -> Acc
            end;
        true -> Acc
        end
    end, Directions, Distances).