-spec num_subarrays_with_sum(Nums :: [integer()], Goal :: integer()) -> integer().
num_subarrays_with_sum(Nums, Goal) ->
    PrefixSums = lists:foldl(fun(Num, Acc) -> 
                                [hd(Acc) + Num | Acc] 
                             end, [0], Nums),
    lists:reverse(PrefixSums),
    Count = maps:new(),
    InitialCount = maps:put(0, 1, Count),
    {Result, _} = lists:foldl(fun(Sum, {Res, Cnt}) ->
                                case maps:get(Sum - Goal, Cnt, 0) of
                                    undefined -> 
                                        {Res, maps:update_with(Sum, fun(V) -> V + 1 end, 1, Cnt)};
                                    V -> 
                                        {Res + V, maps:update_with(Sum, fun(Val) -> Val + 1 end, 1, Cnt)}
                                end
                             end, {0, InitialCount}, PrefixSums),
    Result.