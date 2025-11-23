-module(max_diff_even_odd).
-export([maxDiffEvenOdd/1]).

maxDiffEvenOdd(Nums) ->
    Count = count_freq(Nums, #{}),
    lists:foldl(fun({Key, Val}, Acc) ->
        case Val rem 2 of
            0 -> MaxEven = max(Acc#{{even} := Key, Val}, Acc);
            _ -> MaxOdd = max(Acc#{{odd} := Key, Val}, Acc)
        end
    end, #{even => -1, odd => -1}, maps:to_list(Count)),
    EvenMax = maps:get(even, #{even => -1, odd => -1}),
    OddMax = maps:get(odd, #{even => -1, odd => -1}),
    if
        EvenMax == -1 orelse OddMax == -1 -> -1;
        true -> EvenMax - OddMax
    end.

count_freq([], Acc) -> Acc;
count_freq([H | T], Acc) ->
    NewAcc = case maps:is_key(H, Acc) of
        true -> maps:update(H, maps:get(H, Acc) + 1, Acc);
        false -> maps:put(H, 1, Acc)
    end,
    count_freq(T, NewAcc).

max({Key, Val}, {CurrentKey, CurrentVal}) ->
    if Val > CurrentVal -> {Key, Val};
       true -> {CurrentKey, CurrentVal}
    end.