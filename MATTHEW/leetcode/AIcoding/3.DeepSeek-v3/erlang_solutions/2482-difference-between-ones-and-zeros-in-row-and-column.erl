-spec ones_minus_zeros(Grid :: [[integer()]]) -> [[integer()]].
ones_minus_zeros(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),

    RowOnes = lists:map(fun(Row) -> lists:sum(Row) end, Grid),
    ColOnes = lists:foldl(fun(Row, Acc) ->
                            lists:zipwith(fun(X, Sum) -> X + Sum end, Row, Acc)
                          end, lists:duplicate(Cols, 0), Grid),

    RowZeros = lists:map(fun(Ones) -> Cols - Ones end, RowOnes),
    ColZeros = lists:map(fun(Ones) -> Rows - Ones end, ColOnes),

    lists:map(fun({RowIdx, Row}) ->
        lists:map(fun({ColIdx, _}) ->
            RowOnes1 = lists:nth(RowIdx + 1, RowOnes),
            ColOnes1 = lists:nth(ColIdx + 1, ColOnes),
            RowZeros1 = lists:nth(RowIdx + 1, RowZeros),
            ColZeros1 = lists:nth(ColIdx + 1, ColZeros),
            RowOnes1 + ColOnes1 - RowZeros1 - ColZeros1
        end, lists:zip(lists:seq(0, Cols - 1), Row))
    end, lists:zip(lists:seq(0, Rows - 1), Grid)).