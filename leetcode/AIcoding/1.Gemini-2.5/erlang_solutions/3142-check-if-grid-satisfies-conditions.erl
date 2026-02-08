-module(solution).
-export([satisfiesConditions/1]).

satisfiesConditions(Grid) ->
    M = length(Grid),
    N = length(hd(Grid)),

    Condition1 = check_column_equality(Grid, M, N, 0),
    Condition2 = check_row_difference(Grid, M, N, 0),

    Condition1 and Condition2.

get_element(Grid, Row, Col) ->
    lists:nth(Col + 1, lists:nth(Row + 1, Grid)).

check_column_equality(_Grid, _M, N, N) ->
    true;
check_column_equality(Grid, M, N, Col) ->
    case M of
        1 ->
            check_column_equality(Grid, M, N, Col + 1);
        _ ->
            FirstVal = get_element(Grid, 0, Col),
            check_column_elements(Grid, M, Col, 1, FirstVal) and
            check_column_equality(Grid, M, N, Col + 1)
    end.

check_column_elements(_Grid, M, _Col, M, _FirstVal) ->
    true;
check_column_elements(Grid, M, Col, Row, FirstVal) ->
    CurrentVal = get_element(Grid, Row, Col),
    if
        CurrentVal == FirstVal ->
            check_column_elements(Grid, M, Col, Row + 1, FirstVal);
        true ->
            false
    end.

check_row_difference(_Grid, M, _N, M) ->
    true;
check_row_difference(Grid, M, N, Row) ->
    case N of
        1 ->
            check_row_difference(Grid, M, N, Row + 1);
        _ ->
            check_row_adjacent_elements(Grid, N, Row, 0) and
            check_row_difference(Grid, M, N, Row + 1)
    end.

check_row_adjacent_elements(_Grid, N, _Row, N - 1) ->
    true;
check_row_adjacent_elements(Grid, N, Row, Col) ->
    Val1 = get_element(Grid, Row, Col),
    Val2 = get_element(Grid, Row, Col + 1),
    if
        Val1 /= Val2 ->
            check_row_adjacent_elements(Grid, N, Row, Col + 1);
        true ->
            false
    end.