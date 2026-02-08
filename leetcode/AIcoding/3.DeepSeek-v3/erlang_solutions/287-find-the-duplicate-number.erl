-spec find_duplicate(Nums :: [integer()]) -> integer().
find_duplicate(Nums) ->
    find_duplicate(Nums, 0, 0).

find_duplicate([], Slow, Fast) ->
    find_duplicate_phase2(Slow, Fast);
find_duplicate([H | T], Slow, Fast) ->
    Slow1 = lists:nth(Slow + 1, T),
    Fast1 = lists:nth(lists:nth(Fast + 1, T) + 1, T),
    if
        Slow1 == Fast1 -> find_duplicate_phase2(0, Slow1);
        true -> find_duplicate(T, Slow1, Fast1)
    end.

find_duplicate_phase2(Slow, Fast) ->
    if
        Slow == Fast -> Slow;
        true -> find_duplicate_phase2(lists:nth(Slow + 1, T), lists:nth(Fast + 1, T))
    end.