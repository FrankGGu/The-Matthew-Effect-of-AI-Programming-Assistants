-module(solution).
-export([best_hand/2]).

-spec best_hand(Ranks :: [integer()], Suits :: [char()]) -> unicode:chardata().
best_hand(Ranks, Suits) ->
    IsFlush = (length(sets:from_list(Suits)) == 1),

    RankCounts = lists:foldl(fun(R, Acc) -> 
                                 maps:update_with(R, fun(C) -> C + 1 end, 1, Acc) 
                             end, #{}, Ranks),

    MaxRankCount = lists:foldl(fun({_Rank, Count}, Max) -> 
                                   max(Count, Max) 
                               end, 0, maps:to_list(RankCounts)),

    if
        IsFlush -> "Flush";
        MaxRankCount >= 3 -> "Three of a Kind";
        MaxRankCount >= 2 -> "Pair";
        true -> "High Card"
    end.