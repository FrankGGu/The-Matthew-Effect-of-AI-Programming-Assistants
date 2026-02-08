-spec can_win_nim(N :: integer()) -> boolean().
can_win_nim(N) ->
    N rem 4 =/= 0.