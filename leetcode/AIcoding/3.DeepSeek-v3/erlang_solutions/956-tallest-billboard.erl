-module(solution).
-export([tallest_billboard/1]).

tallest_billboard(Rods) ->
    DP = maps:new(),
    DP1 = maps:put(0, 0, DP),
    lists:foldl(fun(Rod, Acc) ->
        NewAcc = maps:fold(fun(D, T, Map) ->
            Map1 = maps:update_with(D + Rod, fun(V) -> max(V, T + Rod) end, T + Rod, Map),
            maps:update_with(abs(D - Rod), fun(V) -> max(V, T + Rod) end, T + Rod, Map1)
        end, Acc, Acc),
        maps:merge(fun(_, V1, V2) -> max(V1, V2) end, Acc, NewAcc)
    end, DP1, Rods),
    case maps:get(0, DP1, 0) of
        0 -> 0;
        V -> V div 2
    end.