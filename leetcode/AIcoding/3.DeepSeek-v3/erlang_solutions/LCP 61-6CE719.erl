-spec temperature_trend(TemperatureA :: [integer()], TemperatureB :: [integer()]) -> integer().
temperature_trend(TemperatureA, TemperatureB) ->
    {_, MaxLen} = lists:foldl(fun({A1, A2, B1, B2}, {Current, Max}) ->
        TrendA = case A2 - A1 of
            Diff when Diff > 0 -> 1;
            Diff when Diff < 0 -> -1;
            _ -> 0
        end,
        TrendB = case B2 - B1 of
            Diff when Diff > 0 -> 1;
            Diff when Diff < 0 -> -1;
            _ -> 0
        end,
        if
            TrendA =:= TrendB -> {Current + 1, max(Max, Current + 1)};
            true -> {0, Max}
        end
    end, {0, 0}, lists:zip4(lists:sublist(TemperatureA, 1, length(TemperatureA) - 1),
                           lists:sublist(TemperatureA, 2, length(TemperatureA) - 1),
                           lists:sublist(TemperatureB, 1, length(TemperatureB) - 1),
                           lists:sublist(TemperatureB, 2, length(TemperatureB) - 1))),
    MaxLen.