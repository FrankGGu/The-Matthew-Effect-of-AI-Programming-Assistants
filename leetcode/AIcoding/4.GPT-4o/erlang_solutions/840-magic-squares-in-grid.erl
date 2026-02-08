-module(solution).
-export([numMagicSquaresInside/1]).

numMagicSquaresInside(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    count_magic_squares(Grid, Rows, Cols, 0).

count_magic_squares(_, 0, _, Count) -> Count;
count_magic_squares(Grid, Rows, Cols, Count) ->
    Count1 = case is_magic_square(Grid, Rows, Cols) of
                 true -> Count + 1;
                 false -> Count
               end,
    count_magic_squares(Grid, Rows - 1, Cols, Count1);
    count_magic_squares(Grid, Rows, Cols - 1, Count).

is_magic_square(Grid, Row, Col) ->
    case Row >= 3 andalso Col >= 3 of
        false -> false;
        true ->
            Square = [lists:nth(Row + R, Grid) ++ lists:nth(Col + C, Grid) || R <- [0, 1, 2], C <- [0, 1, 2]],
            case lists:usort(Square) =:= [1, 2, 3, 4, 5, 6, 7, 8, 9] of
                false -> false;
                true ->
                    RowSums = [lists:nth(Row + R, Grid) ++ lists:nth(Col + C, Grid) || R <- [0, 1, 2]],
                    ColSums = [lists:nth(Row, Grid) ++ lists:nth(Col + C, Grid) || C <- [0, 1, 2]],
                    Diag1Sum = lists:nth(Row, Grid) + lists:nth(Row + 1, Grid) + lists:nth(Row + 2, Grid),
                    Diag2Sum = lists:nth(Row + 2, Grid) + lists:nth(Row + 1, Grid) + lists:nth(Row, Grid),
                    lists:all(fun(Sum) -> Sum =:= 15 end, RowSums) andalso
                    lists:all(fun(Sum) -> Sum =:= 15 end, ColSums) andalso
                    Diag1Sum =:= 15 andalso
                    Diag2Sum =:= 15
            end
    end.