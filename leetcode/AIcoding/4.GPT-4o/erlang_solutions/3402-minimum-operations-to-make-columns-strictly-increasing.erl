-module(solution).
-export([min_operations/1]).

min_operations(Matrix) ->
    Rows = length(Matrix),
    Columns = length(hd(Matrix)),
    min_ops(Matrix, 0, 0, Rows, Columns).

min_ops(_, ColIndex, PrevVal, Rows, Columns) when ColIndex >= Columns ->
    0;
min_ops(Matrix, ColIndex, PrevVal, Rows, Columns) ->
    NewRowVals = [lists:nth(ColIndex + 1, Row) || Row <- Matrix],
    SortedNewRowVals = lists:sort(NewRowVals),
    Ops = lists:foldl(fun (Val, Acc) ->
        case Val > PrevVal of
            true -> Acc;
            false -> Acc + (PrevVal - Val + 1)
        end
    end, 0, SortedNewRowVals),
    NewPrevVal = lists:last(SortedNewRowVals) + Ops,
    Ops + min_ops(Matrix, ColIndex + 1, NewPrevVal, Rows, Columns).