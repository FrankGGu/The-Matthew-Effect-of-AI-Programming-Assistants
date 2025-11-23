-module(solution).
-export([setZeroes/1]).

setZeroes(Matrix) ->
    Rows = length(Matrix),
    Cols = if Rows > 0 -> length(hd(Matrix)); true -> 0 end,

    ZeroPositions = find_zero_positions(Matrix, 0, []),

    RowsToZero = sets:from_list([R || {R, _} <- ZeroPositions]),
    ColsToZero = sets:from_list([C || {_, C} <- ZeroPositions]),

    [
        [
            if
                sets:is_element(RIdx, RowsToZero) orelse sets:is_element(CIdx, ColsToZero) -> 0;
                true -> Element
            end
        || {Element, CIdx} <- lists:zip(Row, lists:seq(0, Cols - 1))
        ]
    || {Row, RIdx} <- lists:zip(Matrix, lists:seq(0, Rows - 1))
    ].

find_zero_positions([], _RowIdx, Acc) -> Acc;
find_zero_positions([Row | RestRows], RowIdx, Acc) ->
    RowZeroPositions = find_row_zero_positions(Row, RowIdx, 0, []),
    find_zero_positions(RestRows, RowIdx + 1, Acc ++ RowZeroPositions).

find_row_zero_positions([], _RowIdx, _ColIdx, Acc) -> Acc;
find_row_zero_positions([0 | RestCols], RowIdx, ColIdx, Acc) ->
    find_row_zero_positions(RestCols, RowIdx, ColIdx + 1, Acc ++ [{RowIdx, ColIdx}]);
find_row_zero_positions([_ | RestCols], RowIdx, ColIdx, Acc) ->
    find_row_zero_positions(RestCols, RowIdx, ColIdx + 1, Acc).