-module(kth_smallest_number_in_multiplication_table).
-export([kthSmallest/3]).

kthSmallest(Rows, Columns, K) ->
    low = 1,
    high = Rows * Columns,
    kthSmallestHelper(low, high, Rows, Columns, K).

kthSmallestHelper(Low, High, Rows, Columns, K) when Low < High ->
    Mid = (Low + High) div 2,
    Count = countNumbersLessThanOrEqualTo(Mid, Rows, Columns),
    if
        Count >= K -> kthSmallestHelper(Low, Mid, Rows, Columns, K);
        true -> kthSmallestHelper(Mid + 1, High, Rows, Columns, K)
    end;
kthSmallestHelper(Low, _, _, _, _) ->
    Low.

countNumbersLessThanOrEqualTo(N, Rows, Columns) ->
    countNumbersLessThanOrEqualTo(N, Rows, Columns, 1, 0).

countNumbersLessThanOrEqualTo(_, _, _, Row, Acc) when Row > Rows ->
    Acc;
countNumbersLessThanOrEqualTo(N, Rows, Columns, Row, Acc) ->
    Col = min(N div Row, Columns),
    countNumbersLessThanOrEqualTo(N, Rows, Columns, Row + 1, Acc + Col).