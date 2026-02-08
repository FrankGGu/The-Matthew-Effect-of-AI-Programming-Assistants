-spec min_falling_path_sum(Matrix :: [[integer()]]) -> integer().
min_falling_path_sum(Matrix) ->
    N = length(Matrix),
    if
        N == 1 -> hd(hd(Matrix));
        true ->
            DP = lists:duplicate(N, lists:duplicate(N, 0)),
            DP1 = lists:zipwith(fun(Row, I) -> 
                [lists:nth(1, Row) | lists:sublist(Row, 2, N - 1)] 
            end, Matrix, lists:seq(1, N)),
            DP2 = lists:foldl(fun(I, Acc) ->
                Row = lists:nth(I, Acc),
                PrevRow = lists:nth(I - 1, Acc),
                NewRow = lists:map(fun(J) ->
                    Val = lists:nth(J, lists:nth(I, Matrix)),
                    MinPrev = case J of
                        1 -> min(lists:nth(J, PrevRow), lists:nth(J + 1, PrevRow));
                        N -> min(lists:nth(J - 1, PrevRow), lists:nth(J, PrevRow));
                        _ -> min(min(lists:nth(J - 1, PrevRow), lists:nth(J, PrevRow)), lists:nth(J + 1, PrevRow))
                    end,
                    Val + MinPrev
                end, lists:seq(1, N)),
                lists:sublist(Acc, I - 1) ++ [NewRow] ++ lists:nthtail(I, Acc)
            end, DP1, lists:seq(2, N))),
            lists:min(lists:nth(N, DP2))
    end.