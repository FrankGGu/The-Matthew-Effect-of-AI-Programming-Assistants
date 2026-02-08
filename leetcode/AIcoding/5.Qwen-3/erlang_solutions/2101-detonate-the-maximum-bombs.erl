-module(detonate_the_maximum_bombs).
-export([maximumDetonation/1]).

maximumDetonation(Bombs) ->
    Max = 0,
    Detonated = maps:new(),
    lists:foldl(fun({X, Y, R}, Acc) ->
        DetonatedCount = countDetonated(Bombs, X, Y, R, Detonated, 0),
        max(Acc, DetonatedCount)
    end, Max, Bombs).

countDetonated([], _, _, _, _, Count) ->
    Count;
countDetonated([{X1, Y1, R1} | Rest], X, Y, R, Detonated, Count) ->
    case maps:is_key({X1, Y1}, Detonated) of
        true ->
            countDetonated(Rest, X, Y, R, Detonated, Count);
        false ->
            Distance = math:sqrt(math:pow(X - X1, 2) + math:pow(Y - Y1, 2)),
            if
                Distance =< R1 ->
                    NewDetonated = maps:put({X1, Y1}, true, Detonated),
                    NewCount = Count + 1,
                    countDetonated(Rest, X, Y, R, NewDetonated, NewCount);
                true ->
                    countDetonated(Rest, X, Y, R, Detonated, Count)
            end
    end.