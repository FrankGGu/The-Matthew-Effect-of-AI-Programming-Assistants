-spec max_product(S :: unicode:unicode_binary()) -> integer().
max_product(S) ->
    N = byte_size(S),
    MaxLen = array:new(N, {default, 0}),
    MaxLen1 = array:set(0, 1, MaxLen),
    {MaxLen2, _} = lists:foldl(fun(I, {Acc, Center}) ->
        Radius = case Center + array:get(Center, Acc) - 1 >= I of
            true -> min(array:get(2 * Center - I, Acc), Center + array:get(Center, Acc) - I);
            false -> 0
        end,
        L = I - Radius,
        R = I + Radius,
        while(L >= 0 andalso R < N andalso binary:at(S, L) =:= binary:at(S, R)) do
            L = L - 1,
            R = R + 1
        end,
        NewLen = R - I - 1,
        NewAcc = array:set(I, NewLen, Acc),
        NewCenter = case I + NewLen > Center + array:get(Center, Acc) of
            true -> I;
            false -> Center
        end,
        {NewAcc, NewCenter}
    end, {MaxLen1, 0}, lists:seq(1, N - 1)),

    RightMax = array:new(N, {default, 0}),
    RightMax1 = array:set(N - 1, 1, RightMax),
    {RightMax2, _} = lists:foldr(fun(I, {Acc, Center}) ->
        Radius = case Center - array:get(Center, Acc) + 1 =< I of
            true -> min(array:get(2 * Center - I, Acc), I - (Center - array:get(Center, Acc)));
            false -> 0
        end,
        L = I - Radius,
        R = I + Radius,
        while(L >= 0 andalso R < N andalso binary:at(S, L) =:= binary:at(S, R)) do
            L = L - 1,
            R = R + 1
        end,
        NewLen = I - L - 1,
        NewAcc = array:set(I, NewLen, Acc),
        NewCenter = case I - NewLen < Center - array:get(Center, Acc) of
            true -> I;
            false -> Center
        end,
        {NewAcc, NewCenter}
    end, {RightMax1, N - 1}, lists:seq(N - 2, 0, -1)),

    PrefixMax = array:new(N, {default, 0}),
    PrefixMax1 = array:set(0, 1, PrefixMax),
    PrefixMax2 = lists:foldl(fun(I, Acc) ->
        Max = max(array:get(I - 1, Acc), array:get(I, MaxLen2)),
        array:set(I, Max, Acc)
    end, PrefixMax1, lists:seq(1, N - 1)),

    SuffixMax = array:new(N, {default, 0}),
    SuffixMax1 = array:set(N - 1, 1, SuffixMax),
    SuffixMax2 = lists:foldr(fun(I, Acc) ->
        Max = max(array:get(I + 1, Acc), array:get(I, RightMax2)),
        array:set(I, Max, Acc)
    end, SuffixMax1, lists:seq(N - 2, 0, -1)),

    lists:foldl(fun(I, MaxProd) ->
        Prod = array:get(I, PrefixMax2) * array:get(I + 1, SuffixMax2),
        max(MaxProd, Prod)
    end, 0, lists:seq(0, N - 2)).