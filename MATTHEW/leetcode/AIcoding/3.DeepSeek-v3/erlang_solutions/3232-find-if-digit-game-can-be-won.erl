-module(solution).
-export([can_win/1]).

can_win(N) ->
    N rem 10 =/= 0.