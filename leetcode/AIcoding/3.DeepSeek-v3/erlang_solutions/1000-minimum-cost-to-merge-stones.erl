-spec merge_stones(Stones :: [integer()], K :: integer()) -> integer().
merge_stones(Stones, K) ->
    N = length(Stones),
    if
        (N - 1) rem (K - 1) =/= 0 -> -1;
        true ->
            Prefix = lists:foldl(fun(X, Acc) -> [hd(Acc) + X | tl(Acc)] end, [0], Stones),
            PrefixSum = lists:reverse(Prefix),
            DP = array:new([{size, N}, {default, array:new([{size, N}, {default, 0}])}]),
            DP1 = merge_stones_dp(Stones, K, N, PrefixSum, DP, 2),
            array:get(0, array:get(N - 1, DP1))
    end.

merge_stones_dp(Stones, K, N, PrefixSum, DP, Len) ->
    if
        Len > N -> DP;
        true ->
            DP1 = merge_stones_dp_len(Stones, K, N, PrefixSum, DP, Len, 0),
            merge_stones_dp(Stones, K, N, PrefixSum, DP1, Len + 1)
    end.

merge_stones_dp_len(Stones, K, N, PrefixSum, DP, Len, I) ->
    J = I + Len - 1,
    if
        J >= N -> DP;
        true ->
            DP1 = array:set(I, array:set(J, 16#7fffffff, array:get(I, DP)), DP),
            DP2 = merge_stones_dp_mid(Stones, K, N, PrefixSum, DP1, Len, I, J, I),
            merge_stones_dp_len(Stones, K, N, PrefixSum, DP2, Len, I + 1)
    end.

merge_stones_dp_mid(Stones, K, N, PrefixSum, DP, Len, I, J, Mid) ->
    if
        Mid >= J -> DP;
        true ->
            Cost = array:get(I, array:get(Mid, DP)) + array:get(Mid + 1, array:get(J, DP)),
            Current = array:get(I, array:get(J, DP)),
            NewDP = if
                Cost < Current -> array:set(I, array:set(J, Cost, array:get(I, DP)), DP);
                true -> DP
            end,
            merge_stones_dp_mid(Stones, K, N, PrefixSum, NewDP, Len, I, J, Mid + 1)
    end.