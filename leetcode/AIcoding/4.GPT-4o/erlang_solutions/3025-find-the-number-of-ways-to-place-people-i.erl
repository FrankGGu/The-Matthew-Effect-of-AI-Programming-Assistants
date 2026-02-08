-module(solution).
-export([count_ways/2]).

count_ways(N, K) ->
    factorial(N) div (factorial(K) * factorial(N - K)).

factorial(0) -> 1;
factorial(N) -> N * factorial(N - 1).