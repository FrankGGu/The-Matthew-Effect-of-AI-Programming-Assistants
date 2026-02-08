-spec count_hidden_sequences(lower :: integer(), upper :: integer(), differences :: [integer()]) -> integer().
count_hidden_sequences(Lower, Upper, Differences) ->
    {Min, Max, _} = lists:foldl(fun(D, {AccMin, AccMax, Prev}) ->
        Next = Prev + D,
        {min(AccMin, Next), max(AccMax, Next), Next}
    end, {0, 0, 0}, Differences),
    Range = (Upper - Lower) - (Max - Min) + 1,
    if
        Range > 0 -> Range;
        true -> 0
    end.