-module(solution).
-export([num_submatrices_with_all_ones/1]).

num_submatrices_with_all_ones(Matrix) ->
    Rows = length(Matrix),
    Cols = length(hd(Matrix)),
    Matrix1 = lists:map(fun(Row) -> lists:map(fun(X) -> if X == 1 -> 1; true -> 0 end) end, Row) end, Matrix),
    Count = lists:foldl(fun(Row, Acc) -> Acc + count_row_submatrices(Row) end, 0, Matrix1),
    Count.

count_row_submatrices(Row) ->
    count_row_submatrices(Row, 0, 0).

count_row_submatrices([], _, Acc) -> Acc;
count_row_submatrices([H | T], Count, Acc) ->
    case H of
        1 -> count_row_submatrices(T, Count + 1, Acc + Count + 1);
        _ -> count_row_submatrices(T, 0, Acc)
    end.