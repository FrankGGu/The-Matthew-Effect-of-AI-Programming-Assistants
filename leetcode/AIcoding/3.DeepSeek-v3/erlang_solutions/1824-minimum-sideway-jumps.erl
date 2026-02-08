-module(solution).
-export([min_side_jumps/1]).

min_side_jumps(Obstacles) ->
    N = length(Obstacles),
    DP = array:new([{size, N}, {default, array:new([{size, 3}, {default, 0}])}]),
    DP1 = array:set(0, array:set(0, 1, array:new([{size, 3}, {default, 0}])), DP),
    DP2 = array:set(0, array:set(1, 0, array:get(0, DP1)), DP1),
    DP3 = array:set(0, array:set(2, 1, array:get(0, DP2)), DP2),
    solve(1, N, Obstacles, DP3).

solve(I, N, Obstacles, DP) when I < N ->
    Obs = lists:nth(I, Obstacles),
    Prev = array:get(I - 1, DP),
    Current0 = case Obs of
        1 -> infinity;
        _ -> min_prev(Prev, 0)
    end,
    Current1 = case Obs of
        2 -> infinity;
        _ -> min_prev(Prev, 1)
    end,
    Current2 = case Obs of
        3 -> infinity;
        _ -> min_prev(Prev, 2)
    end,
    NewRow = array:set(0, Current0, array:set(1, Current1, array:set(2, Current2, array:new([{size, 3}, {default, 0}])))),
    NewDP = array:set(I, NewRow, DP),
    solve(I + 1, N, Obstacles, NewDP);
solve(I, N, _, DP) when I == N ->
    LastRow = array:get(N - 1, DP),
    lists:min([array:get(0, LastRow), array:get(1, LastRow), array:get(2, LastRow)]).

min_prev(Prev, Lane) ->
    case array:get(Lane, Prev) of
        infinity -> infinity;
        Val -> Val
    end + 0.