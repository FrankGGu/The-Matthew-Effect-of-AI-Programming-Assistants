-module(score_after_flipping_matrix).
-export([matrix_score/1]).

matrix_score(Matrix) ->
    Rows = length(Matrix),
    Cols = length(lists:nth(1, Matrix)),
    FlippedMatrix = flip_rows(Matrix),
    FlippedAndColumnsMatrix = flip_columns(FlippedMatrix),
    calculate_score(FlippedAndColumnsMatrix).

flip_rows(Matrix) ->
    [flip_row(Row) || Row <- Matrix].

flip_row(Row) ->
    case lists:nth(1, Row) of
        0 ->
            [1 - X || X <- Row];
        1 ->
            Row
    end.

flip_columns(Matrix) ->
    Cols = length(lists:nth(1, Matrix)),
    flip_columns_helper(Matrix, 1, Cols, Matrix).

flip_columns_helper(Matrix, Col, Cols, Acc) when Col > Cols ->
    Acc;
flip_columns_helper(Matrix, Col, Cols, Acc) ->
    Column = get_column(Acc, Col),
    if lists:sum(Column) < length(Column) / 2 then
        FlippedMatrix = flip_column(Acc, Col),
        flip_columns_helper(FlippedMatrix, Col + 1, Cols, FlippedMatrix)
    else
        flip_columns_helper(Acc, Col + 1, Cols, Acc)
    end.

get_column(Matrix, Col) ->
    [lists:nth(Col, Row) || Row <- Matrix].

flip_column(Matrix, Col) ->
    [flip_element(Row, Col) || Row <- Matrix].

flip_element(Row, Col) ->
    lists:map_nth(Col, fun(X) -> 1 - X end, Row).

lists:map_nth(N, Fun, List) ->
    lists:zipwith(fun(I, E) ->
                      case I of
                          N -> Fun(E);
                          _ -> E
                      end
                  end, lists:seq(1, length(List)), List).

calculate_score(Matrix) ->
    lists:sum([row_score(Row) || Row <- Matrix]).

row_score(Row) ->
    lists:foldl(fun(X, Acc) -> Acc * 2 + X end, 0, Row).