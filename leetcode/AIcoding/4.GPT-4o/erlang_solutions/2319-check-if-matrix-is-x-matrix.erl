-module(solution).
-export([check_x_matrix/1]).

check_x_matrix(Matrix) ->
    N = length(Matrix),
    check_rows(Matrix, N).

check_rows([], _) -> 
    true;
check_rows([Row | Rest], N) ->
    case check_row(Row, length(Row), N) of
        false -> false;
        true -> check_rows(Rest, N)
    end.

check_row(Row, Length, N) ->
    case Length =:= N of
        false -> false;
        true ->
            check_diagonal(Row, Length, 0) andalso check_non_diagonal(Row, Length, 0)
    end.

check_diagonal(_, 0, _) -> true;
check_diagonal(Row, Length, Index) ->
    case lists:nth(Index + 1, Row) =:= 0 of
        true -> check_diagonal(Row, Length, Index + 1);
        false -> 
            if 
                Index =:= 0 orelse Index =:= Length - 1 -> 
                    check_diagonal(Row, Length, Index + 1);
                true -> 
                    false 
            end
    end.

check_non_diagonal(_, 0, _) -> true;
check_non_diagonal(Row, Length, Index) ->
    case lists:nth(Index + 1, Row) of
        0 -> check_non_diagonal(Row, Length, Index + 1);
        Value -> 
            if 
                Index =:= 0 orelse Index =:= Length - 1 -> 
                    false;
                true -> 
                    check_non_diagonal(Row, Length, Index + 1)
            end
    end.