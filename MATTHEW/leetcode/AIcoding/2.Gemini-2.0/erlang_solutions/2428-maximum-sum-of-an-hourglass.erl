-module(hourglass).
-export([max_hourglass_sum/1]).

max_hourglass_sum(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    max_hourglass_sum_helper(Grid, Rows, Cols, 0, 0, -infinity).

max_hourglass_sum_helper(_Grid, Rows, Cols, Row, Col, MaxSum) when Row > Rows - 3 ->
    MaxSum;
max_hourglass_sum_helper(_Grid, Rows, Cols, Row, Col, MaxSum) when Col > Cols - 3 ->
    max_hourglass_sum_helper(_Grid, Rows, Cols, Row + 1, 0, MaxSum);
max_hourglass_sum_helper(Grid, Rows, Cols, Row, Col, MaxSum) ->
    HourglassSum = calculate_hourglass_sum(Grid, Row, Col),
    NewMaxSum = max(MaxSum, HourglassSum),
    max_hourglass_sum_helper(Grid, Rows, Cols, Row, Col + 1, NewMaxSum).

calculate_hourglass_sum(Grid, Row, Col) ->
    A = lists:nth(Row + 1, Grid),
    B = lists:nth(Row + 2, Grid),
    C = lists:nth(Row + 3, Grid),
    lists:nth(Col + 1, A) + lists:nth(Col + 2, A) + lists:nth(Col + 3, A) +
    lists:nth(Col + 2, B) +
    lists:nth(Col + 1, C) + lists:nth(Col + 2, C) + lists:nth(Col + 3, C).

max(A, B) ->
    if A > B ->
        A;
    true ->
        B
    end.