-module(painting_the_walls).
-export([paint_walls/1]).

paint_walls(Walls) ->
    N = length(Walls),
    DP = array:new(N, {default, 0}),
    paint_walls(Walls, N, 0, DP).

paint_walls(_, _, N, _) when N >= 2 ->
    0;
paint_walls(Walls, N, I, DP) ->
    case array:get(I, DP) of
        V when is_integer(V) ->
            V;
        _ ->
            Cost = lists:nth(I + 1, Walls),
            Case1 = Cost + paint_walls(Walls, N, I + 1, DP),
            Case2 = paint_walls(Walls, N, I + 2, DP),
            Result = min(Case1, Case2),
            array:set(I, Result, DP),
            Result
    end.