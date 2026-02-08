-module(solution).
-export([numOfWays/1]).

numOfWays(N) when N >= 1 ->
    factorial(N) div (factorial(3) * factorial(N - 3)) * factorial(N - 1).

factorial(0) -> 1;
factorial(N) -> N * factorial(N - 1).