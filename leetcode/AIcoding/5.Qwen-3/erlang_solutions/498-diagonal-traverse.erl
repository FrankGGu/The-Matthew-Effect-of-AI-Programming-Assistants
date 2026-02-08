-module(diagonal_traverse).
-export([find_diagonal_order/1]).

find_diagonal_order(Matrix) ->
    find_diagonal_order(Matrix, 0, 0, [], 0).

find_diagonal_order(_, _, _, Result, _) when is_list(Result) -> lists:reverse(Result);
find_diagonal_order(Matrix, Row, Col, Result, Dir) ->
    Rows = length(Matrix),
    Cols = length(hd(Matrix)),
    if
        Row < 0 orelse Col >= Cols orelse Row >= Rows orelse Col < 0 ->
            NewDir = case Dir of
                         0 -> 1;
                         1 -> 0
                     end,
            NextRow = case Dir of
                          0 -> Row + 1;
                          1 -> Row - 1
                      end,
            NextCol = case Dir of
                          0 -> Col - 1;
                          1 -> Col + 1
                      end,
            find_diagonal_order(Matrix, NextRow, NextCol, Result, NewDir);
        true ->
            Value = lists:nth(Row + 1, Matrix),
            Element = lists:nth(Col + 1, Value),
            find_diagonal_order(Matrix, Row + 1, Col - 1, [Element | Result], 0)
    end.