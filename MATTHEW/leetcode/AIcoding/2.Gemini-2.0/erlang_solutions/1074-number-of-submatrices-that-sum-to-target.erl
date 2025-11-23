-module(numSubmatrixSumTarget).
-export([num_submatrix_sum_target/2]).

num_submatrix_sum_target(Matrix, Target) ->
    Rows = length(Matrix),
    Cols = length(hd(Matrix)),

    PrefixSumMatrix = calculate_prefix_sum(Matrix, Rows, Cols),

    count_submatrices(PrefixSumMatrix, Rows, Cols, Target).

calculate_prefix_sum(Matrix, Rows, Cols) ->
    lists:foldl(
        fun(RowIndex, AccPrefixSum) ->
            Row = lists:nth(RowIndex, Matrix),
            PrefixSumRow = lists:foldl(
                fun(ColIndex, AccRow) ->
                    Value = lists:nth(ColIndex, Row),

                    PrevSum = case ColIndex of
                        1 -> 0;
                        _ -> lists:nth(ColIndex - 1, hd(lists:reverse(AccRow)))
                    end,

                    PrevRowSum = case RowIndex of
                        1 -> 0;
                        _ -> lists:nth(ColIndex, lists:nth(RowIndex - 1, AccPrefixSum))
                    end,

                    OverlapSum = case {RowIndex, ColIndex} of
                        {1, 1} -> 0;
                        {1, _} -> 0;
                        {_, 1} -> 0;
                        _ -> lists:nth(ColIndex - 1, lists:nth(RowIndex - 1, AccPrefixSum))
                    end,

                    NewSum = Value + PrevSum + PrevRowSum - OverlapSum,
                    [NewSum | AccRow]
                end,
                [],
                lists:seq(1, Cols)
            ),
            [lists:reverse(PrefixSumRow) | AccPrefixSum]
        end,
        [],
        lists:seq(1, Rows)
    ).

count_submatrices(PrefixSumMatrix, Rows, Cols, Target) ->
    count_submatrices_helper(PrefixSumMatrix, Rows, Cols, Target, 0, 1, 1, 1, 1).

count_submatrices_helper(_PrefixSumMatrix, Rows, Cols, _Target, Count, _, _, Row2, Col2) when Row2 > Rows ->
    Count;
count_submatrices_helper(_PrefixSumMatrix, Rows, Cols, _Target, Count, _, _, Row2, Col2) when Col2 > Cols ->
    count_submatrices_helper(_PrefixSumMatrix, Rows, Cols, _Target, Count, 1, 1, Row2 + 1, 1);
count_submatrices_helper(PrefixSumMatrix, Rows, Cols, Target, Count, Row1, Col1, Row2, Col2) ->
    Sum = calculate_submatrix_sum(PrefixSumMatrix, Row1, Col1, Row2, Col2),
    NewCount = case Sum =:= Target of
        true -> Count + 1;
        false -> Count
    end,
    count_submatrices_helper(PrefixSumMatrix, Rows, Cols, Target, NewCount, Row1, Col1 + 1, Row2, Col2).

calculate_submatrix_sum(PrefixSumMatrix, Row1, Col1, Row2, Col2) ->
    TotalSum = lists:nth(Col2, lists:nth(Row2, PrefixSumMatrix)),

    PrevRowSum = case Row1 of
        1 -> 0;
        _ -> lists:nth(Col2, lists:nth(Row1 - 1, PrefixSumMatrix))
    end,

    PrevColSum = case Col1 of
        1 -> 0;
        _ -> lists:nth(Col1 - 1, lists:nth(Row2, PrefixSumMatrix))
    end,

    OverlapSum = case {Row1, Col1} of
        {1, 1} -> 0;
        {1, _} -> 0;
        {_, 1} -> 0;
        _ -> lists:nth(Col1 - 1, lists:nth(Row1 - 1, PrefixSumMatrix))
    end,

    TotalSum - PrevRowSum - PrevColSum + OverlapSum.