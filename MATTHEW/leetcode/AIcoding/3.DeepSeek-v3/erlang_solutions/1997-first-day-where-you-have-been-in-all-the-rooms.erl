-spec first_day_all_rooms(NextVisit :: [integer()]) -> integer().
first_day_all_rooms(NextVisit) ->
    N = length(NextVisit),
    Mod = 1000000007,
    DP = lists:duplicate(N, 0),
    {DP1, _} = lists:foldl(fun(I, {Dp, _}) ->
        if 
            I == 0 -> {Dp, 0};
            true ->
                Prev = lists:nth(I, Dp),
                Next = lists:nth(I, NextVisit),
                Days = (2 * Prev - lists:nth(Next, Dp) + 2) rem Mod,
                {lists:sublist(Dp, I - 1) ++ [Days] ++ lists:nthtail(I, Dp), Days}
        end
    end, {DP, 0}, lists:seq(1, N - 1)),
    lists:nth(N - 1, DP1) rem Mod.