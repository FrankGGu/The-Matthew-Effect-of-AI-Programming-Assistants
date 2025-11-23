-module(solution).
-export([is_x_matrix/1]).

is_x_matrix(Grid) ->
    N = length(Grid),
    check_rows(Grid, N, 0).

check_rows([], _N, _Row) ->
    true;
check_rows([RowList | RestRows], N, Row) ->
    check_cols(RowList, N, Row, 0) andalso check_rows(RestRows, N, Row + 1).

check_cols([], _N, _Row, _Col) ->
    true;
check_cols([Val | RestVals], N, Row, Col) ->
    IsDiagonal = (Row == Col) orelse (Row + Col == N - 1),
    ConditionMet = 
        if 
            IsDiagonal -> Val /= 0;
            true       -> Val == 0
        end,
    ConditionMet andalso check_cols(RestVals, N, Row, Col + 1).