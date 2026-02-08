-spec stone_game_v(stone_values :: [integer()]) -> integer().
stone_game_v(StoneValues) ->
    N = length(StoneValues),
    Prefix = lists:foldl(fun(X, Acc) -> [hd(Acc) + X | Acc] end, [0], StoneValues),
    PrefixSum = lists:reverse(Prefix),
    DP = array:new([{size, N}, {default, array:new([{size, N}, {default, 0}])}]),
    {Res, _, _} = solve(1, N, PrefixSum, DP),
    Res.

solve(L, R, PrefixSum, DP) ->
    case L >= R of
        true -> {0, array:set(L, array:set(R, 0, array:get(L, DP)), PrefixSum};
        false ->
            case array:get(R, array:get(L, DP)) of
                0 ->
                    Total = lists:nth(R, PrefixSum) - lists:nth(L - 1, PrefixSum),
                    {MaxScore, NewDP, NewPrefixSum} = 
                        lists:foldl(fun(K, {CurrentMax, CurrentDP, CurrentPrefix}) ->
                            LeftSum = lists:nth(K, PrefixSum) - lists:nth(L - 1, PrefixSum),
                            RightSum = Total - LeftSum,
                            if
                                LeftSum < RightSum ->
                                    {LS, DP1, PS1} = solve(L, K, PrefixSum, CurrentDP),
                                    NewScore = LeftSum + LS,
                                    {max(CurrentMax, NewScore), DP1, PS1};
                                LeftSum > RightSum ->
                                    {RS, DP2, PS2} = solve(K + 1, R, PrefixSum, CurrentDP),
                                    NewScore = RightSum + RS,
                                    {max(CurrentMax, NewScore), DP2, PS2};
                                true ->
                                    {LS, DP1, PS1} = solve(L, K, PrefixSum, CurrentDP),
                                    {RS, DP2, PS2} = solve(K + 1, R, PrefixSum, DP1),
                                    NewScore = LeftSum + max(LS, RS),
                                    {max(CurrentMax, NewScore), DP2, PS2}
                            end
                        end, {0, DP, PrefixSum}, lists:seq(L, R - 1)),
                    UpdatedDP = array:set(L, array:set(R, MaxScore, array:get(L, NewDP)), NewDP),
                    {MaxScore, UpdatedDP, NewPrefixSum};
                Cached -> {Cached, DP, PrefixSum}
            end
    end.