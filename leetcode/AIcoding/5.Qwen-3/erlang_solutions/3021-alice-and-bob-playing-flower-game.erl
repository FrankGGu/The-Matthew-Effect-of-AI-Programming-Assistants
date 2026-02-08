-module(flower_game).
-export([can_win/1]).

can_win(N) ->
    lists:foldl(fun(I, Acc) -> Acc andalso (I rem 2 == 0) end, true, lists:seq(1, N)).