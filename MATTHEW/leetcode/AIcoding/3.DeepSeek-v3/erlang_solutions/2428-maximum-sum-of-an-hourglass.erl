-spec max_sum(Grid :: [[integer()]]) -> integer().
max_sum(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    MaxSum = -1,
    max_sum(Grid, Rows, Cols, 1, MaxSum).

max_sum(_Grid, Rows, Cols, I, MaxSum) when I + 2 > Rows ->
    MaxSum;
max_sum(Grid, Rows, Cols, I, MaxSum) ->
    NewMaxSum = max_sum_cols(Grid, Cols, I, 1, MaxSum),
    max_sum(Grid, Rows, Cols, I + 1, NewMaxSum).

max_sum_cols(_Grid, Cols, _I, J, MaxSum) when J + 2 > Cols ->
    MaxSum;
max_sum_cols(Grid, Cols, I, J, MaxSum) ->
    Sum = lists:nth(J, lists:nth(I, Grid)) +
          lists:nth(J + 1, lists:nth(I, Grid)) +
          lists:nth(J + 2, lists:nth(I, Grid)) +
          lists:nth(J + 1, lists:nth(I + 1, Grid)) +
          lists:nth(J, lists:nth(I + 2, Grid)) +
          lists:nth(J + 1, lists:nth(I + 2, Grid)) +
          lists:nth(J + 2, lists:nth(I + 2, Grid)),
    NewMaxSum = max(Sum, MaxSum),
    max_sum_cols(Grid, Cols, I, J + 1, NewMaxSum).