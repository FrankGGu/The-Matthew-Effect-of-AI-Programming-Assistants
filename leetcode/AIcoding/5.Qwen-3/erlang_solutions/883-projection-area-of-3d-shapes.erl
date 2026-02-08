-module(projection_area).
-export([projection_area/1]).

projection_area(Grid) ->
    N = length(Grid),
    Xy = count_xy(Grid),
    Xz = count_xz(Grid),
    Yz = count_yz(Grid),
    Xy + Xz + Yz.

count_xy(Grid) ->
    lists:foldl(fun(Row, Acc) ->
        lists:foldl(fun(Cell, A) -> if Cell > 0 -> A + 1; true -> A end end, Acc, Row)
    end, 0, Grid).

count_xz(Grid) ->
    lists:foldl(fun(Row, Acc) ->
        lists:max(Row) + Acc
    end, 0, Grid).

count_yz(Grid) ->
    N = length(Grid),
    lists:foldl(fun(I, Acc) ->
        lists:foldl(fun(J, A) ->
            Cell = lists:nth(J+1, lists:nth(I+1, Grid)),
            case lists:member(Cell, [lists:nth(J+1, lists:nth(I+1, Grid)) || I2 <- lists:seq(0, N-1)]) of
                true -> A + 1;
                false -> A
            end
        end, Acc, lists:seq(0, N-1))
    end, 0, lists:seq(0, N-1)).