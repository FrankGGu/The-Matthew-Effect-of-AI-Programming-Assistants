-module(increment_submatrices_by_one).
-export([solve/1]).

solve(queries) ->
    N = 100;
    Matrix = lists:duplicate(N, lists:duplicate(N, 0)),
    UpdatedMatrix = increment_matrix(Matrix, queries),
    UpdatedMatrix.

increment_matrix(Matrix, []) ->
    Matrix;
increment_matrix(Matrix, [Query|Rest]) ->
    [Row1, Col1, Row2, Col2] = Query,
    UpdatedMatrix = increment_submatrix(Matrix, Row1, Col1, Row2, Col2),
    increment_matrix(UpdatedMatrix, Rest).

increment_submatrix(Matrix, Row1, Col1, Row2, Col2) ->
    lists:map(fun(RowIndex) ->
                      increment_row(lists:nth(RowIndex + 1, Matrix), Col1, Col2)
              end, lists:seq(Row1, Row2)).

increment_row(Row, Col1, Col2) ->
    lists:map(fun(ColIndex) ->
                      increment_cell(lists:nth(ColIndex + 1, Row))
              end, lists:seq(Col1, Col2)).

increment_cell(Value) ->
    Value + 1.

increment_submatrix(Matrix, Row1, Col1, Row2, Col2) ->
    lists:mapi(fun(RowIndex, Row) ->
                      case RowIndex >= Row1 + 1 andalso RowIndex <= Row2 + 1 of
                          true -> lists:mapi(fun(ColIndex, Value) ->
                                                    case ColIndex >= Col1 + 1 andalso ColIndex <= Col2 + 1 of
                                                        true -> Value + 1;
                                                        false -> Value
                                                    end
                                            end, Row);
                          false -> Row
                      end
              end, Matrix).

solve(N, Queries) ->
    Matrix = lists:duplicate(N, lists:duplicate(N, 0)),
    increment_matrix2(Matrix, Queries).

increment_matrix2(Matrix, []) ->
    Matrix;
increment_matrix2(Matrix, [Query|Rest]) ->
    [Row1, Col1, Row2, Col2] = Query,
    UpdatedMatrix = lists:mapi(fun(RowIndex, Row) ->
                                    case RowIndex >= Row1 andalso RowIndex =< Row2 of
                                        true -> lists:mapi(fun(ColIndex, Value) ->
                                                                  case ColIndex >= Col1 andalso ColIndex =< Col2 of
                                                                      true -> Value + 1;
                                                                      false -> Value
                                                                  end
                                                          end, Row);
                                        false -> Row
                                    end
                                end, Matrix),
    increment_matrix2(UpdatedMatrix, Rest).