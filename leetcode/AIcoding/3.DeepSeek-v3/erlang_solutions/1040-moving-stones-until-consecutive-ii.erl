-spec num_moves_stones_ii(Stones :: [integer()]) -> [integer()].
num_moves_stones_ii(Stones) ->
    Sorted = lists:sort(Stones),
    N = length(Sorted),
    Max = lists:max([lists:nth(N, Sorted) - lists:nth(2, Sorted) - N + 2,
                     lists:nth(N - 1, Sorted) - lists:nth(1, Sorted) - N + 2]),
    Min = N,
    {Min1, I, J} = lists:foldl(fun(Stone, {MinAcc, IAcc, JAcc}) ->
        while JAcc < N andalso lists:nth(JAcc + 1, Sorted) =< Stone + N - 1 do
            JAcc = JAcc + 1
        end,
        Cost = N - (JAcc - IAcc + 1),
        if
            Cost =:= 1 andalso lists:nth(JAcc, Sorted) - lists:nth(IAcc, Sorted) =:= N - 2 ->
                MinAcc1 = min(MinAcc, 2);
            true ->
                MinAcc1 = min(MinAcc, Cost)
        end,
        {MinAcc1, IAcc + 1, JAcc}
    end, {N, 0, 0}, Sorted),
    [Min1, Max].