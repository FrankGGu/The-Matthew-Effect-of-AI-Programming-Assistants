-module(winner_of_circular_game).
-export([game/2]).

game(N, K) ->
    game(N, K, 0).

game(1, _, Winner) ->
    Winner;
game(N, K, Winner) ->
    game(N - 1, K, (Winner + K) rem N).