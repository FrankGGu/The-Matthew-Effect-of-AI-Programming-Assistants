-spec num_special(Mat :: [[integer()]]) -> integer().
num_special(Mat) ->
    Rows = length(Mat),
    Cols = length(hd(Mat)),
    RowCount = lists:map(fun(Row) -> lists:sum(Row) end, Mat),
    ColCount = lists:foldl(fun(Row, Acc) ->
        lists:zipwith(fun(X, Sum) -> X + Sum end, Row, Acc)
    end, lists:duplicate(Cols, 0), Mat),
    lists:sum([
        1 || I <- lists:seq(0, Rows - 1), J <- lists:seq(0, Cols - 1),
        lists:nth(I + 1, RowCount) == 1,
        lists:nth(J + 1, ColCount) == 1,
        lists:nth(J + 1, lists:nth(I + 1, Mat)) == 1
    ]).