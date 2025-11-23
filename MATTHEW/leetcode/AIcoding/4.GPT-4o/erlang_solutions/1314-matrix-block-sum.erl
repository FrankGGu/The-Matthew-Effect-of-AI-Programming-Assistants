-module(solution).
-export([matrix_block_sum/2]).

matrix_block_sum(Matrix, K) ->
    {Rows, Cols} = lists:zip(lists:seq(1, length(Matrix)), lists:map(fun Row -> length(Row) end, Matrix)),
    lists:map(fun({RowIndex, Row}) ->
                    lists:map(fun(ColIndex) ->
                                    sum_block(Matrix, RowIndex, ColIndex, K)
                                end, lists:seq(1, Cols))
                end, lists:zip(Rows, Matrix)).

sum_block(Matrix, RowIndex, ColIndex, K) ->
    RowStart = max(1, RowIndex - K),
    RowEnd = min(length(Matrix), RowIndex + K),
    ColStart = max(1, ColIndex - K),
    ColEnd = min(length(hd(Matrix)), ColIndex + K),
    lists:sum([lists:sum(lists:sublist(Row, ColStart, ColEnd - ColStart + 1)) || Row <- lists:sublist(Matrix, RowStart, RowEnd - RowStart + 1)]).