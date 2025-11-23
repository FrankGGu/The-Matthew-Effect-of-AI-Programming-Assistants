-spec maximum_population(Logs :: [[integer()]]) -> integer().
maximum_population(Logs) ->
    Years = lists:seq(1950, 2050),
    Counts = lists:foldl(fun([Birth, Death], Acc) ->
                                lists:foldl(fun(Year, AccIn) ->
                                                maps:update_with(Year, fun(V) -> V + 1 end, 1, AccIn)
                                            end, Acc, lists:seq(Birth, Death - 1))
                         end, #{}, Logs),
    {MaxYear, _} = lists:foldl(fun(Year, {CurrentYear, CurrentMax}) ->
                                    Count = maps:get(Year, Counts, 0),
                                    if
                                        Count > CurrentMax -> {Year, Count};
                                        true -> {CurrentYear, CurrentMax}
                                    end
                               end, {1950, 0}, Years),
    MaxYear.