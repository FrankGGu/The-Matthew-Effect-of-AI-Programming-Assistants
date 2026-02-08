-module(circular_game).
-export([circular_game_winner/1]).

circular_game_winner(N) ->
  lists:foldl(fun(K, Acc) -> (Acc + 2) rem K end, 0, lists:seq(2, N)) + 1.