-module(minimum_sideway_jumps).
-export([minimum_sideway_jumps/1]).

minimum_sideway_jumps(Obstacles) ->
    N = length(Obstacles),
    Dist = array:new([1, 3], {1000000000}),
    array:set(Dist, {1, 2}, 0),
    minimum_sideway_jumps_helper(Obstacles, Dist, 1, N).

minimum_sideway_jumps_helper(Obstacles, Dist, Pos, N) when Pos == N ->
    MinDist1 = array:get(Dist, {1, 1}),
    MinDist2 = array:get(Dist, {1, 2}),
    MinDist3 = array:get(Dist, {1, 3}),
    min([MinDist1, MinDist2, MinDist3]);

minimum_sideway_jumps_helper(Obstacles, Dist, Pos, N) ->
    O = lists:nth(Pos, Obstacles),
    array:set(Dist, {1, O}, 1000000000),
    MinDist1 = array:get(Dist, {1, 1}),
    MinDist2 = array:get(Dist, {1, 2}),
    MinDist3 = array:get(Dist, {1, 3}),

    if O =/= 1 ->
        D2 = array:get(Dist, {1, 2}),
        D3 = array:get(Dist, {1, 3}),
        if D2 + 1 < D3 then
            array:set(Dist, {1, 3}, D2 + 1)
        else if D3 + 1 < D2 then
            array:set(Dist, {1, 2}, D3 + 1)
        else
            ok
        end
    else
        ok
    end,

    if O =/= 2 ->
        D1 = array:get(Dist, {1, 1}),
        D3 = array:get(Dist, {1, 3}),
        if D1 + 1 < D3 then
            array:set(Dist, {1, 3}, D1 + 1)
        else if D3 + 1 < D1 then
            array:set(Dist, {1, 1}, D3 + 1)
        else
            ok
        end
    else
        ok
    end,

    if O =/= 3 ->
        D1 = array:get(Dist, {1, 1}),
        D2 = array:get(Dist, {1, 2}),
        if D1 + 1 < D2 then
            array:set(Dist, {1, 2}, D1 + 1)
        else if D2 + 1 < D1 then
            array:set(Dist, {1, 1}, D2 + 1)
        else
            ok
        end
    else
        ok
    end,

    minimum_sideway_jumps_helper(Obstacles, Dist, Pos + 1, N).