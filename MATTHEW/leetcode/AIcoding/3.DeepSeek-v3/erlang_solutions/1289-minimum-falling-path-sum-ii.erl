-spec min_falling_path_sum(Grid :: [[integer()]]) -> integer().
min_falling_path_sum(Grid) ->
    N = length(Grid),
    if
        N == 1 -> hd(hd(Grid));
        true ->
            DP = lists:duplicate(N, lists:duplicate(N, 0)),
            DP1 = lists:zipwith(fun(Row, I) ->
                lists:zipwith(fun(Val, J) ->
                    if
                        I == 0 -> Val;
                        true ->
                            MinPrev = lists:min([lists:nth(K, lists:nth(I, DP)) || K <- lists:seq(1, N), K =/= J]),
                            Val + MinPrev
                    end
                end, Row, lists:seq(1, N))
            end, Grid, lists:seq(0, N-1)),
            lists:min(lists:last(DP1))
    end.