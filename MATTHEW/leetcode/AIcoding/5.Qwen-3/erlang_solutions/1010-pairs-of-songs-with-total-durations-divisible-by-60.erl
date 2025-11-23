-module(solution).
-export([num_music_pairs/1]).

num_music_pairs(Durations) ->
    Count = lists:foldl(fun(Duration, Acc) -> 
        Remainder = Duration rem 60,
        case Remainder of
            0 -> maps:update(0, maps:get(0, Acc, 0) + 1, Acc);
            _ -> maps:update(Remainder, maps:get(Remainder, Acc, 0) + 1, Acc)
        end
    end, maps:new(), Durations),
    lists:foldl(fun({Rem, C}, Acc) ->
        if
            Rem == 0 -> Acc + (C * (C - 1)) div 2;
            true -> 
                Complement = 60 - Rem,
                if
                    Complement == 60 -> Acc + (C * maps:get(0, Count, 0));
                    true -> Acc + (C * maps:get(Complement, Count, 0))
                end
        end
    end, 0, maps:to_list(Count)).