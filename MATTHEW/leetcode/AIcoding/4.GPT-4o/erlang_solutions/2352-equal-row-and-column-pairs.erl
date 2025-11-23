-module(solution).
-export([equal_row_and_column_pairs/1]).

equal_row_and_column_pairs(Matrix) ->
    Rows = lists:map(fun(Row) -> Row end, Matrix),
    Cols = lists:map(fun(Col) -> lists:map(fun(Row) -> lists:nth(Col, Row) end, Matrix) end, lists:seq(1, length(Matrix))),
    Count = lists:foldl(fun(Row, Acc) -> Acc + lists:count(fun(X) -> X == Row end, Cols) end, 0, Rows),
    Count.