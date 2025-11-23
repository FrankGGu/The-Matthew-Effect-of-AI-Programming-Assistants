-module(solution).
-export([areOccurrencesEqual/1]).

areOccurrencesEqual(S) ->
    FreqMap = lists:foldl(
        fun(Char, AccMap) ->
            maps:update_with(Char, fun(Count) -> Count + 1 end, 1, AccMap)
        end,
        #{},
        S
    ),

    Counts = maps:values(FreqMap),

    case Counts of
        [] ->
            true;
        [FirstCount | RestCounts] ->
            lists:all(fun(Count) -> Count == FirstCount end, RestCounts)
    end.