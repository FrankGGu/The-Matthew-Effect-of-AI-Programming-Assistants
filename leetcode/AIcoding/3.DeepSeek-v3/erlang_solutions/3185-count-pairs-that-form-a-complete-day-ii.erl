-module(solution).
-export([count_complete_day_pairs/1]).

count_complete_day_pairs(Hours) ->
    Counts = maps:new(),
    {Result, _} = lists:foldl(fun(Hour, {Acc, CountsMap}) ->
        Rem = Hour rem 24,
        Needed = (24 - Rem) rem 24,
        case maps:get(Needed, CountsMap, 0) of
            0 -> {Acc, maps:put(Rem, maps:get(Rem, CountsMap, 0) + 1, CountsMap)};
            C -> {Acc + C, maps:put(Rem, maps:get(Rem, CountsMap, 0) + 1, CountsMap)}
        end
    end, {0, Counts}, Hours),
    Result.