-spec climb_stairs(N :: integer()) -> integer().
climb_stairs(N) when N == 1 -> 1;
climb_stairs(N) when N == 2 -> 2;
climb_stairs(N) -> climb_stairs(N - 1) + climb_stairs(N - 2).
