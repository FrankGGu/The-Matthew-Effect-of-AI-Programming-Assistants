-module(solution).
-export([unique_paths/2]).

unique_paths(M, N) ->
    factorial(M + N - 2) div (factorial(M - 1) * factorial(N - 1)).

factorial(0) -> 1;
factorial(N) when N > 0 -> N * factorial(N - 1).