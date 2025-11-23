-module(find_the_winner).
-export([find_the_winner/3]).

find_the_winner(N, K, Choice) ->
  find_the_winner_helper(N, K, Choice, 1).

find_the_winner_helper(N, K, Choice, Current) ->
  New_position = ((Current - 1) + K) rem N + 1,
  New_position.