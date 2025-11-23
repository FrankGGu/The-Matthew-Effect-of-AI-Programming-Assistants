-module(solution).
-export([count_negatives/1]).

count_negatives(Matrix) ->
    Count = lists:foldl(fun(Row, Acc) ->
        Acc + count_negatives_in_row(Row)
    end, 0, Matrix),
    Count.

count_negatives_in_row(Row) ->
    lists:foldl(fun(X, Acc) ->
        if
            X < 0 -> Acc + 1;
            true -> Acc
        end
    end, 0, Row).