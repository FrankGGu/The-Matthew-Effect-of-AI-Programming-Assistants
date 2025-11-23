-module(num_matrix).
-export([new/1, sum_region/4]).

new(Matrix) ->
    {Rows, Cols} = matrix_size(Matrix),
    PrefixSum = lists:foldl(fun(RowIndex, Acc) ->
        Row = lists:nth(RowIndex + 1, Matrix),
        RowSum = lists:foldl(fun(ColIndex, RowAcc) ->
            Value = lists:nth(ColIndex + 1, Row),
            PrevSum = case ColIndex of
                0 -> 0;
                _ -> lists:nth(ColIndex, lists:last(Acc))
            end,
            RowAcc ++ [Value + PrevSum]
        end, [], lists:seq(0, Cols - 1)),
        Acc ++ [RowSum]
    end, [], lists:seq(0, Rows - 1)),
    {Rows, Cols, PrefixSum}.

sum_region(Row1, Col1, Row2, Col2, {Rows, Cols, PrefixSum}) ->
    Top = case Row1 of
        0 -> 0;
        _ -> lists:nth(Col2 + 1, lists:nth(Row1, PrefixSum))
    end,
    Left = case Col1 of
        0 -> 0;
        _ -> lists:nth(Col1, lists:nth(Row2 + 1, PrefixSum))
    end,
    TopLeft = case {Row1, Col1} of
        {0, 0} -> 0;
        {0, _} -> 0;
        {_, 0} -> 0;
        _ -> lists:nth(Col1, lists:nth(Row1, PrefixSum))
    end,
    lists:nth(Col2 + 1, lists:nth(Row2 + 1, PrefixSum)) - Top - Left + TopLeft.

matrix_size(Matrix) ->
    Rows = length(Matrix),
    Cols = case Matrix of
        [] -> 0;
        [FirstRow | _] -> length(FirstRow)
    end,
    {Rows, Cols}.