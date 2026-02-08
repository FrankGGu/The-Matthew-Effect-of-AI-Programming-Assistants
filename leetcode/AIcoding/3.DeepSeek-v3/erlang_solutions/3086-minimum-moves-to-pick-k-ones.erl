-spec min_moves(nums :: [integer()], k :: integer()) -> integer().
min_moves(Nums, K) ->
    Ones = [I || {I, X} <- lists:zip(lists:seq(0, length(Nums) - 1), Nums), X =:= 1],
    case length(Ones) < K of
        true -> -1;
        false ->
            Prefix = lists:foldl(fun(X, Acc) -> [hd(Acc) + X | tl(Acc)] end, [0], Ones),
            PrefixSum = lists:reverse(Prefix),
            min_moves(Ones, PrefixSum, K)
    end.

min_moves(Ones, PrefixSum, K) ->
    Len = length(Ones),
    Min = lists:min(
        lists:map(
            fun(I) ->
                Left = I,
                Right = I + K - 1,
                Mid = (Left + Right) div 2,
                Radius = Mid - Left,
                OnesMid = lists:nth(Mid + 1, Ones),
                CostRight = (PrefixSum !! (Right + 2)) - (PrefixSum !! (Mid + 2)),
                CostLeft = (PrefixSum !! (Mid + 1)) - (PrefixSum !! (Left + 1)),
                (OnesMid * Radius - CostLeft) + (CostRight - OnesMid * Radius) - (Radius * (Radius + 1) div 2) * 2
            end,
            lists:seq(0, Len - K)
        ),
    Min.

'!!'(List, Index) when Index > length(List) -> 0;
'!!'(List, Index) -> lists:nth(Index, List).