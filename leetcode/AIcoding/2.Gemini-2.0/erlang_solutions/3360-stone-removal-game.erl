-module(stone_removal).
-export([canWinNim/1]).

canWinNim(N) ->
    N rem 4 /= 0.