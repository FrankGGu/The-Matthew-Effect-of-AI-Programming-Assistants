-spec get_row(RowIndex :: integer()) -> [integer()].
get_row(RowIndex) ->
    get_row(RowIndex, [1]).

get_row(0, Row) -> Row;
get_row(RowIndex, Row) ->
    NextRow = [1 | [lists:nth(I, Row) + lists:nth(I + 1, Row) || I <- lists:seq(1, length(Row) - 1)] ++ [1]],
    get_row(RowIndex - 1, NextRow).