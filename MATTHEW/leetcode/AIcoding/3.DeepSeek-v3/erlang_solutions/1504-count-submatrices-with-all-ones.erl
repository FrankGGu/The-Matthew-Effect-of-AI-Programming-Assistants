-spec num_submat(Mat :: [[integer()]]) -> integer().
num_submat(Mat) ->
    Rows = length(Mat),
    Cols = length(hd(Mat)),
    DP = lists:duplicate(Rows, lists:duplicate(Cols, 0)),
    {DP1, _} = lists:mapfoldl(fun(Row, Acc) ->
        {RowDP, _} = lists:mapfoldl(fun(Col, Acc1) ->
            case lists:nth(Col + 1, lists:nth(Row + 1, Mat)) of
                0 -> {0, Acc1};
                1 ->
                    Prev = if Row == 0 -> 0; true -> lists:nth(Col + 1, lists:nth(Row, DP)) end,
                    Curr = Prev + 1,
                    {Curr, Acc1 + Curr}
            end
        end, 0, lists:seq(0, Cols - 1)),
        {RowDP, Acc + lists:sum(RowDP)}
    end, 0, lists:seq(0, Rows - 1)),
    DP1.