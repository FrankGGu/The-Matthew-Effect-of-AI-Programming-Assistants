-spec max_sum_submatrix(Matrix :: [[integer()]], K :: integer()) -> integer().
max_sum_submatrix(Matrix, K) ->
    max_sum_submatrix(Matrix, K, 0).

max_sum_submatrix([], _, MaxSum) -> MaxSum;
max_sum_submatrix([Row | Rest], K, MaxSum) ->
    NewMax = max_sum_submatrix_for_row(Row, Rest, K, MaxSum),
    max_sum_submatrix(Rest, K, NewMax).

max_sum_submatrix_for_row(_, [], _, MaxSum) -> MaxSum;
max_sum_submatrix_for_row(Row, [NextRow | Rest], K, MaxSum) ->
    NewMax = max_sum_submatrix_for_columns(Row, NextRow, K, MaxSum),
    max_sum_submatrix_for_row(Row, Rest, K, NewMax).

max_sum_submatrix_for_columns(Row, NextRow, K, MaxSum) ->
    SubmatrixSum = sum_submatrix(Row, NextRow),
    if 
        SubmatrixSum =< K -> max(MaxSum, SubmatrixSum);
        true -> MaxSum
    end.

sum_submatrix([], _) -> 0;
sum_submatrix([H | T], [NH | NT]) -> H + NH + sum_submatrix(T, NT).
