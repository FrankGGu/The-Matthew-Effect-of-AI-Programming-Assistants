-spec climb_stairs(N :: integer()) -> integer().
climb_stairs(N) ->
    climb_stairs(N, 1, 1).

climb_stairs(0, A, _B) -> A;
climb_stairs(N, A, B) ->
    climb_stairs(N - 1, B, A + B).