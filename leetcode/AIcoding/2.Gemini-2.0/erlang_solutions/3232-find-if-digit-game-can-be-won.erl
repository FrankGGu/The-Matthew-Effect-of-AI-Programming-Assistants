-module(digit_game).
-export([digit_game/2]).

digit_game(N, K) ->
  Len = length(integer_to_list(N)),
  case Len rem 2 of
    0 -> Len >= K;
    1 -> Len > K
  end.