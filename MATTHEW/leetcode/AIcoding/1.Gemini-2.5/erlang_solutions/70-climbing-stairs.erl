-module(solution).
-export([climb_stairs/1]).

climb_stairs(1) -> 1;
climb_stairs(2) -> 2;
climb_stairs(N) when N > 2 ->
    climb(3, N, 1, 2).

climb(N, N, _Prev2, Prev1) ->
    Prev1;
climb(Current, N, Prev2, Prev1) ->
    climb(Current + 1, N, Prev1, Prev2 + Prev1).