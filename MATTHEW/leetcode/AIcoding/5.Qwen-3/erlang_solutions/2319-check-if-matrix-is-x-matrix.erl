-module(solution).
-export([isXMatrix/1]).

isXMatrix(Matrix) ->
    isXMatrix(Matrix, 0, length(Matrix) - 1).

isXMatrix([], _, _) ->
    true;
isXMatrix([Row | Rest], RowIndex, MaxIndex) ->
    case isXRow(Row, RowIndex, MaxIndex) of
        true -> isXMatrix(Rest, RowIndex + 1, MaxIndex);
        false -> false
    end.

isXRow([], _, _) ->
    true;
isXRow([Value | Rest], RowIndex, MaxIndex) ->
    ColumnIndex = length(Row) - length([Value | Rest]) - 1,
    if
        (RowIndex == ColumnIndex) orelse (RowIndex + ColumnIndex == MaxIndex) ->
            isXRow(Rest, RowIndex, MaxIndex);
        true ->
            Value /= 0 andalso isXRow(Rest, RowIndex, MaxIndex)
    end.