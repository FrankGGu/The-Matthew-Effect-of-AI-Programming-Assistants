-module(minimum_sideway_jumps).
-export([minSidewaysJumps/1]).

minSidewaysJumps(Road) ->
    N = length(Road),
    DP = array:new([{size, 3}, {default, 0}]),
    DP1 = array:set(0, 0, DP),
    DP2 = array:set(1, 1, DP1),
    DP3 = array:set(2, 2, DP2),
    minSidewaysJumps(Road, 0, DP3).

minSidewaysJumps([], _, DP) ->
    array:get(0, DP) < array:get(1, DP) andalso array:get(0, DP) < array:get(2, DP) andalso array:get(0, DP) orelse
    array:get(1, DP) < array:get(2, DP) andalso array:get(1, DP) orelse
    array:get(2, DP).

minSidewaysJumps([H | T], I, DP) ->
    NextDP = array:new([{size, 3}, {default, 0}]),
    case H of
        0 ->
            NextDP1 = array:set(0, array:get(0, DP), NextDP),
            NextDP2 = array:set(1, array:get(1, DP) + 1, NextDP1),
            NextDP3 = array:set(2, array:get(2, DP) + 1, NextDP2),
            minSidewaysJumps(T, I + 1, NextDP3);
        1 ->
            NextDP1 = array:set(0, array:get(0, DP) + 1, NextDP),
            NextDP2 = array:set(1, array:get(1, DP), NextDP1),
            NextDP3 = array:set(2, array:get(2, DP) + 1, NextDP2),
            minSidewaysJumps(T, I + 1, NextDP3);
        2 ->
            NextDP1 = array:set(0, array:get(0, DP) + 1, NextDP),
            NextDP2 = array:set(1, array:get(1, DP) + 1, NextDP1),
            NextDP3 = array:set(2, array:get(2, DP), NextDP2),
            minSidewaysJumps(T, I + 1, NextDP3)
    end.