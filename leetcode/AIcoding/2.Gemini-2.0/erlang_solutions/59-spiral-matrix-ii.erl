-module(spiral_matrix_ii).
-export([generate_matrix/1]).

generate_matrix(N) ->
  generate_matrix(N, 1, 0, 0, 0, 0, []).

generate_matrix(N, Num, RowStart, RowEnd, ColStart, ColEnd, Acc) when Num > N * N ->
  matrix_to_list_of_lists(lists:reverse(Acc), N);
generate_matrix(N, Num, RowStart, RowEnd, ColStart, ColEnd, Acc) ->
  NewAcc1 = fill_row(Num, RowStart, ColStart, ColEnd - 1, Acc),
  NewNum1 = Num + (ColEnd - ColStart),
  case NewNum1 > N * N of
    true ->
      matrix_to_list_of_lists(lists:reverse(NewAcc1), N);
    false ->
      NewAcc2 = fill_col(NewNum1, ColEnd - 1, RowStart + 1, RowEnd, NewAcc1),
      NewNum2 = NewNum1 + (RowEnd - RowStart - 1),
      case NewNum2 > N * N of
        true ->
          matrix_to_list_of_lists(lists:reverse(NewAcc2), N);
        false ->
          NewAcc3 = fill_row_reverse(NewNum2, RowEnd - 1, ColEnd - 2, ColStart, NewAcc2),
          NewNum3 = NewNum2 + (ColEnd - ColStart - 1),
          case NewNum3 > N * N of
            true ->
              matrix_to_list_of_lists(lists:reverse(NewAcc3), N);
            false ->
              NewAcc4 = fill_col_reverse(NewNum3, ColStart, RowEnd - 2, RowStart + 1, NewAcc3),
              NewNum4 = NewNum3 + (RowEnd - RowStart - 2),
              generate_matrix(N, NewNum4, RowStart + 1, RowEnd - 1, ColStart + 1, ColEnd - 1, NewAcc4)
          end
      end
  end.

fill_row(Num, Row, ColStart, ColEnd, Acc) when ColStart > ColEnd ->
  Acc;
fill_row(Num, Row, ColStart, ColEnd, Acc) ->
  NewAcc = [{Row, ColStart, Num} | Acc],
  fill_row(Num + 1, Row, ColStart + 1, ColEnd, NewAcc).

fill_row_reverse(Num, Row, ColEnd, ColStart, Acc) when ColEnd < ColStart ->
  Acc;
fill_row_reverse(Num, Row, ColEnd, ColStart, Acc) ->
  NewAcc = [{Row, ColEnd, Num} | Acc],
  fill_row_reverse(Num + 1, Row, ColEnd - 1, ColStart, NewAcc).

fill_col(Num, Col, RowStart, RowEnd, Acc) when RowStart > RowEnd ->
  Acc;
fill_col(Num, Col, RowStart, RowEnd, Acc) ->
  NewAcc = [{RowStart, Col, Num} | Acc],
  fill_col(Num + 1, Col, RowStart + 1, RowEnd, NewAcc).

fill_col_reverse(Num, Col, RowEnd, RowStart, Acc) when RowEnd < RowStart ->
  Acc;
fill_col_reverse(Num, Col, RowEnd, RowStart, Acc) ->
  NewAcc = [{RowEnd, Col, Num} | Acc],
  fill_col_reverse(Num + 1, Col, RowEnd - 1, RowStart, NewAcc).

matrix_to_list_of_lists(Matrix, N) ->
  matrix_to_list_of_lists(Matrix, N, 0, []).

matrix_to_list_of_lists(Matrix, N, Row, Acc) when Row >= N ->
  lists:reverse(Acc);
matrix_to_list_of_lists(Matrix, N, Row, Acc) ->
  RowList = [proplists:get_value({Row, Col}, Matrix, 0) || Col <- lists:seq(0, N - 1)],
  matrix_to_list_of_lists(Matrix, N, Row + 1, [RowList | Acc]).