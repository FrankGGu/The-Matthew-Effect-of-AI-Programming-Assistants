-module(x_matrix).
-export([check_x_matrix/1]).

check_x_matrix(Grid) ->
    N = length(Grid),
    check_x_matrix(Grid, N, 0).

check_x_matrix(Grid, N, I) when I >= N ->
    true;
check_x_matrix(Grid, N, I) ->
    Row = lists:nth(I + 1, Grid),
    check_row(Row, N, I, 0, Grid).

check_row(Row, N, I, J, Grid) when J >= N ->
    check_x_matrix(Grid, N, I + 1);
check_row(Row, N, I, J, Grid) ->
    Val = lists:nth(J + 1, Row),
    case (I == J) orelse (I + J == N - 1) of
        true ->
            case Val == 0 of
                true -> false;
                false -> check_row(Row, N, I, J + 1, Grid)
            end;
        false ->
            case Val == 0 of
                true -> check_row(Row, N, I, J + 1, Grid);
                false -> false
            end
    end.