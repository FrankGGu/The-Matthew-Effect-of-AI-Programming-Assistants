-module(solution).
-export([num_submatrices/2]).

num_submatrices(Matrix, K) ->
    Rows = length(Matrix),
    Cols = length(hd(Matrix)),
    Count = 0,
    lists:foldl(fun(RowIdx, Acc) ->
        lists:foldl(fun(ColIdx, Acc2) ->
            Sum = get_sum(Matrix, RowIdx, ColIdx),
            if
                Sum < K -> Acc2 + 1;
                true -> Acc2
            end
        end, Acc, lists:seq(0, Cols - 1))
    end, Count, lists:seq(0, Rows - 1)).

get_sum(Matrix, RowIdx, ColIdx) ->
    lists:foldl(fun(Row, Acc) ->
        lists:foldl(fun(Col, Acc2) ->
            case Row >= RowIdx andalso Col >= ColIdx of
                true -> Acc2 + lists:nth(Row + 1, Matrix) -- lists:nth(Col + 1, lists:nth(Row + 1, Matrix));
                false -> Acc2
            end
        end, Acc, lists:seq(0, length(lists:nth(Row + 1, Matrix)) - 1))
    end, 0, lists:seq(RowIdx, length(Matrix) - 1)).