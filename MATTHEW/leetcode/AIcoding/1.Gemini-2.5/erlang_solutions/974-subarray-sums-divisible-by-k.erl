-spec subarray_sums_divisible_by_k(Nums :: [integer()], K :: integer()) -> integer().
subarray_sums_divisible_by_k(Nums, K) ->
    {Count, _, _} = lists:foldl(
        fun(Num, {AccCount, AccSum, RemainderMap}) ->
            NewSum = AccSum + Num,
            Remainder = (NewSum rem K + K) rem K,
            case maps:find(Remainder, RemainderMap) of
                {ok, Freq} ->
                    {AccCount + Freq, NewSum, maps:update(Remainder, Freq + 1, RemainderMap)};
                error ->
                    {AccCount, NewSum, maps:put(Remainder, 1, RemainderMap)}
            end
        end,
        {0, 0, #{0 => 1}},
        Nums
    ),
    Count.