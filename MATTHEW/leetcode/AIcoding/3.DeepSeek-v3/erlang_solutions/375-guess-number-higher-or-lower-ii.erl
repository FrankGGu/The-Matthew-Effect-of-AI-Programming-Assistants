-spec get_money_amount(N :: integer()) -> integer().
get_money_amount(N) ->
    DP = lists:duplicate(N + 1, lists:duplicate(N + 1, 0)),
    solve(1, N, DP).

solve(Start, End, DP) when Start >= End ->
    0;
solve(Start, End, DP) ->
    case lists:nth(Start, lists:nth(End, DP)) of
        0 ->
            Min = lists:min(
                lists:map(
                    fun(X) ->
                        X + max(solve(Start, X - 1, DP), solve(X + 1, End, DP))
                    end,
                    lists:seq(Start, End)
                )
            ),
            NewRow = lists:sublist(lists:nth(End, DP), Start - 1) ++ [Min] ++ lists:nthtail(Start, lists:nth(End, DP)),
            NewDP = lists:sublist(DP, End - 1) ++ [NewRow] ++ lists:nthtail(End, DP),
            solve(Start, End, NewDP);
        Val ->
            Val
    end.