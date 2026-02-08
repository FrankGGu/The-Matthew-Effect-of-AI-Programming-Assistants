-spec subarrays_with_k_distinct(Nums :: [integer()], K :: integer()) -> integer().
subarrays_with_k_distinct(Nums, K) ->
    AtMostK(Nums, K) - AtMostK(Nums, K - 1).

AtMostK(Nums, K) ->
    Count = maps:new(),
    {Res, _, _} = lists:foldl(fun(N, {Acc, Left, Unique}) ->
        case maps:is_key(N, Count) of
            true -> ok;
            false -> Unique = Unique + 1
        end,
        maps:put(N, maps:get(N, Count, 0) + 1, Count),
        while(Unique > K, fun() ->
            LeftN = lists:nth(Left, Nums),
            case maps:get(LeftN, Count) of
                1 ->
                    maps:remove(LeftN, Count),
                    Unique = Unique - 1;
                _ ->
                    maps:put(LeftN, maps:get(LeftN, Count) - 1, Count)
            end,
            Left = Left + 1
        end),
        Acc = Acc + (length(Nums) - Left + 1),
        {Acc, Left, Unique}
    end, {0, 1, 0}, lists:seq(1, length(Nums))),
    Res.

while(Condition, Body) ->
    case Condition of
        true ->
            Body(),
            while(Condition, Body);
        false -> ok
    end.