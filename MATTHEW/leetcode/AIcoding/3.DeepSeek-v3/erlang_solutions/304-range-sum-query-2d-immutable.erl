-record(matrix, {sums}).

init(NumMatrix) ->
    Rows = length(NumMatrix),
    case Rows of
        0 -> #matrix{sums = []};
        _ ->
            Cols = length(hd(NumMatrix)),
            Sums = lists:foldl(fun(Row, Acc) ->
                RowSum = lists:foldl(fun(X, {Prev, SumAcc}) ->
                    Sum = Prev + X,
                    {Sum, [Sum | SumAcc]}
                end, {0, []}, Row),
                {_, RevRowSums} = RowSum,
                [lists:reverse(RevRowSums) | Acc]
            end, [], NumMatrix),
            #matrix{sums = Sums}
    end.

sumRegion(#matrix{sums = Sums}, Row1, Col1, Row2, Col2) ->
    case Sums of
        [] -> 0;
        _ ->
            lists:sum(lists:map(fun(R) ->
                RowSums = lists:nth(R + 1, Sums),
                case Col1 of
                    0 -> lists:nth(Col2 + 1, RowSums);
                    _ -> lists:nth(Col2 + 1, RowSums) - lists:nth(Col1, RowSums)
                end
            end, lists:seq(Row1, Row2)))
    end.