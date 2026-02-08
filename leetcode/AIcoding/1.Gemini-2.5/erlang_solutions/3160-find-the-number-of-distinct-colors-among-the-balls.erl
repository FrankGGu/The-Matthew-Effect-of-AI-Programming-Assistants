-module(solution).
-export([distinct_colors/2]).

distinct_colors(N, Queries) ->
    InitialBallColors = array:new([{size, N}, {default, 0}]),
    InitialColorCounts = #{0 => N},
    InitialDistinctColors = gb_sets:add(0, gb_sets:empty()),
    process_queries(Queries, InitialBallColors, InitialColorCounts, InitialDistinctColors, []).

process_queries([], _BallColors, _ColorCounts, _DistinctColors, AccResult) ->
    lists:reverse(AccResult);
process_queries([[Index, NewColor] | RestQueries], CurrentBallColors, CurrentColorCounts, CurrentDistinctColors, AccResult) ->
    OldColor = array:get(Index, CurrentBallColors),
    NewBallColors = array:set(Index, NewColor, CurrentBallColors),

    UpdatedColorCounts1 = maps:update(OldColor, maps:get(OldColor, CurrentColorCounts) - 1, CurrentColorCounts),
    UpdatedColorCounts2 = maps:update_with(NewColor, fun(C) -> C + 1 end, 1, UpdatedColorCounts1),

    NewDistinctColors =
        case maps:get(OldColor, UpdatedColorCounts2) of
            0 -> gb_sets:delete(OldColor, CurrentDistinctColors);
            _ -> CurrentDistinctColors
        end,
    FinalDistinctColors = gb_sets:add(NewColor, NewDistinctColors),

    CurrentAnswer = gb_sets:size(FinalDistinctColors),

    process_queries(RestQueries, NewBallColors, UpdatedColorCounts2, FinalDistinctColors, [CurrentAnswer | AccResult]).