-spec repeated_n_times(List :: [integer()]) -> integer().
repeated_n_times(List) ->
    repeated_n_times(List, #{}).

repeated_n_times([H | T], Map) ->
    case maps:get(H, Map, 0) of
        1 -> H;
        _ -> repeated_n_times(T, maps:put(H, 1, Map))
    end.