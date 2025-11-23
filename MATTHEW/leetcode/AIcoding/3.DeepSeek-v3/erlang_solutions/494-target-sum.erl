-spec find_target_sum_ways(Nums :: [integer()], Target :: integer()) -> integer().
find_target_sum_ways(Nums, Target) ->
    Sum = lists:sum(Nums),
    if
        Target > Sum; Target < -Sum -> 0;
        true ->
            DP = maps:from_list([{0, 1}]),
            find_target_sum_ways(Nums, Target, DP)
    end.

find_target_sum_ways([], _, DP) ->
    maps:get(0, DP, 0);
find_target_sum_ways([Num | Rest], Target, DP) ->
    NewDP = maps:new(),
    F = fun(Key, Value, Acc) ->
            Plus = Key + Num,
            Minus = Key - Num,
            Acc1 = maps:update_with(Plus, fun(V) -> V + Value end, Value, Acc),
            maps:update_with(Minus, fun(V) -> V + Value end, Value, Acc1)
        end,
    UpdatedDP = maps:fold(F, NewDP, DP),
    find_target_sum_ways(Rest, Target, UpdatedDP).