-module(solution).
-export([count_possible_sets/1]).

count_possible_sets(N) when N >= 0 ->
    factorial(N) div (factorial(N div 2) * factorial(N - N div 2)).

factorial(0) -> 1;
factorial(N) -> N * factorial(N - 1).