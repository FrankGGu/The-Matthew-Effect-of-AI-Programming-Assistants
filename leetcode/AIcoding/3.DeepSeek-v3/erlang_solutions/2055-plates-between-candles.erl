-spec plates_between_candles(S :: unicode:unicode_binary(), Queries :: [[integer()]]) -> [integer()].
plates_between_candles(S, Queries) ->
    SList = binary_to_list(S),
    N = length(SList),
    Prefix = lists:foldl(fun
        ($|, {Sum, Acc}) -> {Sum, [Sum | Acc]};
        ($*, {Sum, Acc}) -> {Sum + 1, [Sum | Acc]};
        (_, {Sum, Acc}) -> {Sum, [Sum | Acc]}
    end, {0, []}, SList),
    PrefixSum = lists:reverse(element(2, Prefix)),

    Left = lists:foldl(fun
        (Char, {Pos, Acc}) ->
            case Char of
                $| -> {Pos, [Pos | Acc]};
                _ -> {Pos + 1, [Pos | Acc]}
            end
    end, {0, []}, SList),
    LeftCandle = lists:reverse(element(2, Left))),

    Right = lists:foldr(fun
        (Char, {Pos, Acc}) ->
            case Char of
                $| -> {Pos, [Pos | Acc]};
                _ -> {Pos - 1, [Pos | Acc]}
            end
    end, {N - 1, []}, SList),
    RightCandle = element(2, Right),

    lists:map(fun([L, R]) ->
        LeftPos = lists:nth(L + 1, RightCandle),
        RightPos = lists:nth(R + 1, LeftCandle),
        if
            LeftPos >= RightPos -> 0;
            true -> lists:nth(RightPos + 1, PrefixSum) - lists:nth(LeftPos + 1, PrefixSum)
        end
    end, Queries).