-module(longest_well_performing_interval).
-export([longestWELLInterval/1]).

longestWELLInterval(Reports) ->
    Map = maps:from_list([{R, 0} || R <- Reports]),
    {_, Max} = lists:foldl(fun(R, {Count, Max}) ->
        case maps:get(R, Map) of
            0 -> {Count + 1, max(Max, Count + 1)};
            _ -> {Count, Max}
        end
    end, {0, 0}, Reports),
    Max.