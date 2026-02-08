-module(solution).
-export([number_game/1]).

number_game(Nums) ->
    SortedNums = lists:sort(Nums),
    build_result(SortedNums, []).

build_result([A, B | Rest], Acc) ->
    build_result(Rest, [B, A | Acc]);
build_result([], Acc) ->
    lists:reverse(Acc).