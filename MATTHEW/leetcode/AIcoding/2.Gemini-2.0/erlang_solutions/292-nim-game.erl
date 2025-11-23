-module(nim_game).
-export([can_win_nim/1]).

can_win_nim(N) ->
    N rem 4 /= 0.