-spec count_servers(Matrix :: [[integer()]]) -> integer().
count_servers(Matrix) ->
    Rows = length(Matrix),
    case Rows of
        0 -> 0;
        _ ->
            Cols = length(hd(Matrix)),
            RowCount = lists:map(fun(Row) -> lists:sum(Row) end, Matrix),
            ColCount = lists:foldl(fun(Row, Acc) ->
                lists:zipwith(fun(X, Sum) -> X + Sum end, Row, Acc)
            end, lists:duplicate(Cols, 0), Matrix),
            lists:sum([
                case (lists:nth(R + 1, RowCount) > 1) orelse (lists:nth(C + 1, ColCount) > 1) of
                    true -> 1;
                    false -> 0
                end
                || R <- lists:seq(0, Rows - 1), C <- lists:seq(0, Cols - 1), lists:nth(C + 1, lists:nth(R + 1, Matrix)) =:= 1
            ])
    end.