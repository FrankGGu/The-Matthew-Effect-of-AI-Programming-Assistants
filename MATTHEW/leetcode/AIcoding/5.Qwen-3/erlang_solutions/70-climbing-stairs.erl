-module(climbing_stairs).
-export([climb_stairs/1]).

climb_stairs(0) -> 0;
climb_stairs(1) -> 1;
climb_stairs(2) -> 2;
climb_stairs(N) when N > 2 ->
    climb_stairs(N - 1) + climb_stairs(N - 2).