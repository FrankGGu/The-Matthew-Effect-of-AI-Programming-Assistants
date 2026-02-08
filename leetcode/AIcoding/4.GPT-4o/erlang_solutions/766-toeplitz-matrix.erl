-module(solution).
-export([is_toeplitz_matrix/1]).

is_toeplitz_matrix(Matrix) ->
    Rows = length(Matrix),
    Columns = length(hd(Matrix)),
    lists:foldl(fun({RowIndex, Row}, Acc) ->
        case Acc of
            false -> false;
            true -> check_diagonal(Matrix, RowIndex, 0, Rows, Columns)
        end
    end, true, lists:with_index(Matrix)).

check_diagonal(Matrix, RowIndex, ColIndex, Rows, Columns) ->
    case RowIndex + ColIndex >= Rows orelse ColIndex >= Columns of
        true -> true;
        false ->
            CurrentValue = lists:nth(ColIndex + 1, lists:nth(RowIndex + 1, Matrix)),
            NextRowIndex = RowIndex + 1,
            NextColIndex = ColIndex + 1,
            case NextRowIndex < Rows of
                true -> 
                    NextValue = lists:nth(NextColIndex + 1, lists:nth(NextRowIndex + 1, Matrix)),
                    if
                        CurrentValue == NextValue -> check_diagonal(Matrix, NextRowIndex, NextColIndex, Rows, Columns);
                        true -> false
                    end;
                false -> true
            end
    end.