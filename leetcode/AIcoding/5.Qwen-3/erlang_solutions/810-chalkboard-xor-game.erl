-module(chalkboard_xor_game).
-export([xorGame/1]).

xorGame(Nums) ->
    lists:foldl(fun(X, Acc) -> Acc bxor X end, 0, Nums) == 0.