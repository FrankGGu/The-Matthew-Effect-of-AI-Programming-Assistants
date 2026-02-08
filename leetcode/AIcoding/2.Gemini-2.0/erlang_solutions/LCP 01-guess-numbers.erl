-module(guess_numbers).
-export([game/1]).

game(Nums) ->
    lists:foldl(fun(X, Acc) -> if X =:= lists:nth(X, Nums) then Acc + 1 else Acc end, 0, lists:seq(1,3)).