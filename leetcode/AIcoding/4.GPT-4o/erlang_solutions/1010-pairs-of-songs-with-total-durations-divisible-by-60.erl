-module(solution).
-export([numPairsDivisibleBy60/1]).

numPairsDivisibleBy60(Songs) ->
    Counts = lists:foldl(fun(Song, Acc) ->
        Remainder = Song rem 60,
        NewAcc = maps:update_with(Remainder, fun(X) -> X + 1 end, 1, Acc),
        NewAcc
    end, #{}, Songs),
    lists:foldl(fun({K, V}, Acc) ->
        case K of
            0 -> Acc + (V * (V - 1)) div 2;
            30 -> Acc + (V * (V - 1)) div 2;
            _ -> Acc + (maps:get(60 - K, Counts, 0) * V)
        end
    end, 0, maps:to_list(Counts)).