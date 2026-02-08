-module(coin_game).
-export([get_winner/1]).

get_winner(N) ->
  if N rem 2 == 0 then
    2
  else
    1
  end.