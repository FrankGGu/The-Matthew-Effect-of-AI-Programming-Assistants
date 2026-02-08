-module(solution).
-export([stone_game_vi/1]).

stone_game_vi(Stones) ->
    Combined = lists:map(fun([A, B]) -> {A + B, A, B} end, Stones),
    Sorted = lists:sort(fun({Sum1, _, _}, {Sum2, _, _}) -> Sum1 >= Sum2 end, Combined),
    {Alice, Bob} = lists:foldl(fun({_, A, B}, {AccA, AccB}) -> {AccB + A, AccA + B} end, {0, 0}, Sorted),
    if
        Alice > Bob -> 1;
        Alice < Bob -> -1;
        true -> 0
    end.