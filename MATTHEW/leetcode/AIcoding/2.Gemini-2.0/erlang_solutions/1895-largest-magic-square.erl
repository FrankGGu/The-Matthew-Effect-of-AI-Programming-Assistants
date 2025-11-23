-module(largest_magic_square).
-export([largestMagicSquare/1]).

largestMagicSquare(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    Size = min(Rows, Cols),
    largestMagicSquareHelper(Grid, Rows, Cols, Size).

largestMagicSquareHelper(Grid, Rows, Cols, Size) ->
    if Size =< 1 then
        1
    else
        case isMagicSquare(Grid, Rows, Cols, Size) of
            true ->
                Size;
            false ->
                largestMagicSquareHelper(Grid, Rows, Cols, Size - 1)
        end
    end.

isMagicSquare(Grid, Rows, Cols, Size) ->
    lists:foldl(
        fun(R, Acc) ->
            Acc andalso checkSubgrid(Grid, Rows, Cols, Size, R, 0)
        end,
        false,
        lists:seq(0, Rows - Size)
    ) orelse
    lists:foldl(
        fun(C, Acc) ->
            Acc andalso checkSubgrid(Grid, Rows, Cols, Size, 0, C)
        end,
        false,
        lists:seq(0, Cols - Size)
    ).

checkSubgrid(Grid, Rows, Cols, Size, StartRow, StartCol) ->
    Sum = calculateSum(Grid, Size, StartRow, StartCol),
    checkRows(Grid, Size, StartRow, StartCol, Sum) andalso
    checkCols(Grid, Size, StartRow, StartCol, Sum) andalso
    checkDiagonals(Grid, Size, StartRow, StartCol, Sum).

calculateSum(Grid, Size, StartRow, StartCol) ->
    lists:sum([lists:nth(StartCol + I + 1, lists:nth(StartRow + 1, Grid)) || I <- lists:seq(0, Size - 1)]).

checkRows(Grid, Size, StartRow, StartCol, Sum) ->
    lists:all(
        fun(R) ->
            RowSum = lists:sum([lists:nth(StartCol + C + 1, lists:nth(StartRow + R + 1, Grid)) || C <- lists:seq(0, Size - 1)]),
            RowSum =:= Sum
        end,
        lists:seq(0, Size - 1)
    ).

checkCols(Grid, Size, StartRow, StartCol, Sum) ->
    lists:all(
        fun(C) ->
            ColSum = lists:sum([lists:nth(StartCol + 1 + C, lists:nth(StartRow + R + 1, Grid)) || R <- lists:seq(0, Size - 1)]),
            ColSum =:= Sum
        end,
        lists:seq(0, Size - 1)
    ).

checkDiagonals(Grid, Size, StartRow, StartCol, Sum) ->
    Diag1Sum = lists:sum([lists:nth(StartCol + I + 1, lists:nth(StartRow + I + 1, Grid)) || I <- lists:seq(0, Size - 1)]),
    Diag2Sum = lists:sum([lists:nth(StartCol + Size - 1 - I + 1, lists:nth(StartRow + I + 1, Grid)) || I <- lists:seq(0, Size - 1)]),
    Diag1Sum =:= Sum andalso Diag2Sum =:= Sum.