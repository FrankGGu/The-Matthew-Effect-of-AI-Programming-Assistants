-module(solution).
-export([ball_game/2]).

ball_game(N, K) ->
    lists:nth(K+1, lists:seq(1, N)).