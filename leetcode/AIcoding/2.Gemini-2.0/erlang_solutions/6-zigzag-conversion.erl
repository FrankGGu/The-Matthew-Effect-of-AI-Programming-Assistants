-module(zigzag).
-export([convert/2]).

convert(S, NumRows) ->
  convert(S, NumRows, []).

convert(S, NumRows, Acc) ->
  Len = length(S),
  if Len == 0 ->
    list_to_binary(lists:flatten(lists:reverse(Acc)));
  NumRows == 1 ->
    list_to_binary(S);
  true ->
    Rows = lists:seq(1, NumRows),
    Matrix = lists:map(fun(_) -> [] end, Rows),
    FilledMatrix = fill_matrix(S, NumRows, Matrix, 1, 1, true),
    Result = lists:flatten(FilledMatrix),
    list_to_binary(Result)
  end.

fill_matrix([], _NumRows, Matrix, _Row, _Col, _Down) ->
  Matrix;
fill_matrix([Char|Rest], NumRows, Matrix, Row, Col, Down) ->
  NewMatrix = lists:update_element(Row, lists:insert_at(1, Char, lists:nth(Row, Matrix)), Matrix),
  case Down of
    true ->
      if Row + 1 > NumRows ->
        fill_matrix(Rest, NumRows, NewMatrix, Row - 1, Col + 1, false);
      true ->
        fill_matrix(Rest, NumRows, NewMatrix, Row + 1, Col + 1, true)
      end;
    false ->
      if Row - 1 < 1 ->
        fill_matrix(Rest, NumRows, NewMatrix, Row + 1, Col + 1, true);
      true ->
        fill_matrix(Rest, NumRows, NewMatrix, Row - 1, Col + 1, false)
      end
  end.