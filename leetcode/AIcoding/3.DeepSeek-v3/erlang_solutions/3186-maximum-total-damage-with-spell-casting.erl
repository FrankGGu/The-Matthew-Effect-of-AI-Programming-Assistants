-spec maximum_total_damage(Power :: [integer()]) -> integer().
maximum_total_damage(Power) ->
    Sorted = lists:sort(Power),
    DP = maps:new(),
    {Max, _} = lists:foldl(fun(P, {AccMax, AccDP}) ->
        case maps:get(P - 1, AccDP, 0) of
            0 ->
                case maps:get(P - 2, AccDP, 0) of
                    0 ->
                        NewVal = maps:get(P, AccDP, 0) + P,
                        NewDP = maps:put(P, NewVal, AccDP),
                        {max(AccMax, NewVal), NewDP};
                    Prev2 ->
                        NewVal = max(maps:get(P, AccDP, 0), Prev2) + P,
                        NewDP = maps:put(P, NewVal, AccDP),
                        {max(AccMax, NewVal), NewDP}
                end;
            Prev1 ->
                case maps:get(P - 2, AccDP, 0) of
                    0 ->
                        NewVal = max(maps:get(P, AccDP, 0), Prev1) + P,
                        NewDP = maps:put(P, NewVal, AccDP),
                        {max(AccMax, NewVal), NewDP};
                    Prev2 ->
                        NewVal = max(maps:get(P, AccDP, 0), max(Prev1, Prev2)) + P,
                        NewDP = maps:put(P, NewVal, AccDP),
                        {max(AccMax, NewVal), NewDP}
                end
        end
    end, {0, DP}, Sorted),
    Max.