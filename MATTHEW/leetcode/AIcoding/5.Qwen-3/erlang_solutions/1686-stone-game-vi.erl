-module(stone_game_vi).
-export([stoneGameVI/2]).

stoneGameVI(As, Bs) ->
    Players = lists:zip(As, Bs),
    Sorted = lists:sort(fun({A1, B1}, {A2, B2}) -> (A1 + B1) > (A2 + B2) end, Players),
    A = 0,
    B = 0,
    lists:foldl(fun({A1, B1}, {Aacc, Bacc}) -> {Aacc + A1, Bacc + B1} end, {A, B}, Sorted).

stoneGameVI(As, Bs) ->
    stoneGameVI(As, Bs).