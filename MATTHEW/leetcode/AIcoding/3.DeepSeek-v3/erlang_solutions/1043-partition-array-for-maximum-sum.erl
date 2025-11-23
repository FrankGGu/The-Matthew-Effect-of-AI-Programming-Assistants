-spec maxSumAfterPartitioning(Arr :: [integer()], K :: integer()) -> integer().
maxSumAfterPartitioning(Arr, K) ->
    N = length(Arr),
    DP = array:new([{size, N + 1}, {default, 0}]),
    DP1 = populate_dp(Arr, K, N, DP),
    array:get(N, DP1).

populate_dp(Arr, K, N, DP) ->
    populate_dp(Arr, K, N, DP, 1).

populate_dp(Arr, K, N, DP, I) when I > N ->
    DP;
populate_dp(Arr, K, N, DP, I) ->
    CurrentMax = 0,
    {NewDP, _} = lists:foldl(
        fun(J, {AccDP, MaxVal}) ->
            if
                J > I -> {AccDP, MaxVal};
                true ->
                    Index = I - J + 1,
                    if
                        Index < 1 -> {AccDP, MaxVal};
                        true ->
                            Element = lists:nth(Index, Arr),
                            NewMaxVal = max(MaxVal, Element),
                            CurrentSum = array:get(I - J, AccDP) + NewMaxVal * J,
                            NewDP1 = array:set(I, max(array:get(I, AccDP), CurrentSum), AccDP),
                            {NewDP1, NewMaxVal}
                    end
            end
        end,
        {DP, CurrentMax},
        lists:seq(1, K)
    ),
    populate_dp(Arr, K, N, NewDP, I + 1).