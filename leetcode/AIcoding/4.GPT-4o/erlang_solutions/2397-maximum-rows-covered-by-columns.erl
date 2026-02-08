-module(solution).
-export([maximum_rows/2]).

maximum_rows(N, M) ->
    Rows = lists:seq(0, N - 1),
    Columns = lists:seq(0, M - 1),
    MaximumRowsCovered = maximum_rows_helper(Rows, Columns, N, M),
    MaximumRowsCovered.

maximum_rows_helper(Rows, Columns, N, M) ->
    lists:foldl(fun(Row, Acc) ->
        lists:foldl(fun(Column, Acc2) ->
            CoveredRows = lists:filter(fun(X) -> lists:member(X, Acc2) end, Rows),
            if length(CoveredRows) > length(Acc) -> CoveredRows;
            true -> Acc
            end
        end, Acc, Columns)
    end, [], Rows).