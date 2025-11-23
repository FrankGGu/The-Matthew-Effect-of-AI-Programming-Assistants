-module(special_positions_in_binary_matrix).
-export([num_special/1]).

num_special(Matrix) ->
    Rows = length(Matrix),
    Cols = length(hd(Matrix)),
    Count = 0,
    num_special(Matrix, 0, Rows, Cols, Count).

num_special(_, _, Rows, _, Count) when Rows == 0 ->
    Count;
num_special(Matrix, RowIdx, Rows, Cols, Count) ->
    Row = lists:nth(RowIdx + 1, Matrix),
    ColIdx = find_single_one(Row),
    if
        ColIdx == -1 ->
            num_special(Matrix, RowIdx + 1, Rows - 1, Cols, Count);
        true ->
            IsSpecial = check_column(Matrix, ColIdx, RowIdx),
            NewCount = if IsSpecial -> Count + 1; true -> Count end,
            num_special(Matrix, RowIdx + 1, Rows - 1, Cols, NewCount)
    end.

find_single_one(List) ->
    find_single_one(List, 0, -1).

find_single_one([], _, _) ->
    -1;
find_single_one([H | T], Index, FoundIndex) ->
    if
        H == 1 ->
            if FoundIndex == -1 -> find_single_one(T, Index + 1, Index); true -> -1 end;
        true ->
            find_single_one(T, Index + 1, FoundIndex)
    end.

check_column(_, _, _) when not is_integer(_) ->
    false;
check_column(Matrix, ColIdx, RowIdx) ->
    Count = 0,
    check_column(Matrix, ColIdx, RowIdx, 0, Count).

check_column(_, _, _, _, Count) when Count > 1 ->
    false;
check_column(_, _, _, Rows, Count) when Rows == 0 ->
    Count == 1;
check_column(Matrix, ColIdx, RowIdx, Row, Count) ->
    CurrentRow = lists:nth(Row + 1, Matrix),
    Value = lists:nth(ColIdx + 1, CurrentRow),
    if
        Value == 1 ->
            check_column(Matrix, ColIdx, RowIdx, Row + 1, Count + 1);
        true ->
            check_column(Matrix, ColIdx, RowIdx, Row + 1, Count)
    end.