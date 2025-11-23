-module(minimum_number_game).
-export([min_num/1]).

min_num(Nums) ->
    NumsSorted = lists:sort(Nums),
    play(NumsSorted, []).

play([], Acc) ->
    lists:reverse(Acc);
play([A, B | T], Acc) ->
    play(T, [B, A | Acc]).