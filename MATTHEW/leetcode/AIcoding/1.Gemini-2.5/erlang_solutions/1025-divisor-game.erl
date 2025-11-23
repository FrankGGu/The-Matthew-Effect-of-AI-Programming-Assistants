-module(solution).
-export([divisorGame/1]).

divisorGame(N) ->
    (N rem 2 == 0).