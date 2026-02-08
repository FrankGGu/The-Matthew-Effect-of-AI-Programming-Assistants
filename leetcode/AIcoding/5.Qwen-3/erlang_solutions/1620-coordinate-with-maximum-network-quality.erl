-module(max_network_quality).
-export([bestCoordinate/1]).

bestCoordinate(Networks) ->
    MaxQuality = lists:foldl(fun({X, Y, Q}, Acc) -> max(Acc, Q) end, 0, Networks),
    FindBestCoordinate(Networks, MaxQuality, 0, {0, 0}).

FindBestCoordinate([], _, _, Best) -> Best;
FindBestCoordinate([{X, Y, Q} | Rest], Target, MinDist, Best) ->
    if
        Q == Target ->
            Dist = X * X + Y * Y,
            if
                Dist < MinDist ->
                    FindBestCoordinate(Rest, Target, Dist, {X, Y});
                true ->
                    FindBestCoordinate(Rest, Target, MinDist, Best)
            end;
        true ->
            FindBestCoordinate(Rest, Target, MinDist, Best)
    end.