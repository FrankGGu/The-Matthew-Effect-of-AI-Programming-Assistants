-module(minimum_area_rectangle).
-export([solve/1]).

solve(Matrix) ->
    Rows = length(Matrix),
    Cols = length(hd(Matrix)),
    Ones = find_ones(Matrix, Rows, Cols, []),
    case Ones of
        [] -> 0;
        [First | Rest] ->
            MinX = lists:min([X || {X, _} <- Ones]),
            MaxX = lists:max([X || {X, _} <- Ones]),
            MinY = lists:min([Y || {_, Y} <- Ones]),
            MaxY = lists:max([Y || {_, Y} <- Ones]),
            (MaxX - MinX + 1) * (MaxY - MinY + 1)
    end.

find_ones(Matrix, Rows, Cols, Acc) ->
    find_ones(Matrix, Rows, Cols, 0, 0, Acc).

find_ones(_Matrix, Rows, _Cols, X, _, Acc) when X >= Rows ->
    Acc;
find_ones(Matrix, Rows, Cols, X, Y, Acc) when Y >= Cols ->
    find_ones(Matrix, Rows, Cols, X + 1, 0, Acc);
find_ones(Matrix, Rows, Cols, X, Y, Acc) ->
    case lists:nth(X + 1, Matrix) of
        Row ->
            case lists:nth(Y + 1, Row) of
                1 ->
                    find_ones(Matrix, Rows, Cols, X, Y + 1, [{X, Y} | Acc]);
                _ ->
                    find_ones(Matrix, Rows, Cols, X, Y + 1, Acc)
            end;
        _ ->
            find_ones(Matrix, Rows, Cols, X + 1, 0, Acc)
    end.