-spec min_increment_operations(Nums :: [integer()], K :: integer()) -> integer().
min_increment_operations(Nums, K) ->
    DP = lists:foldl(fun(_, Acc) -> maps:new() end, maps:new(), lists:seq(1, 3)),
    solve(Nums, K, 0, 0, DP).

solve([], _, _, _, _) -> 0;
solve([Num | Rest], K, Prev1, Prev2, DP) ->
    Key = {Prev1, Prev2},
    case maps:find(Key, DP) of
        {ok, Val} -> Val;
        error ->
            Needed = max(0, K - Num),
            Case1 = Needed + solve(Rest, K, Needed, Prev1, DP),
            Case2 = solve(Rest, K, 0, Prev1, DP),
            Res = min(Case1, Case2),
            DP1 = maps:put(Key, Res, DP),
            Res
    end.