-module(tribonacci).
-export([tribonacci/1]).

tribonacci(N) when N == 0 -> 0;
tribonacci(N) when N == 1 -> 1;
tribonacci(N) when N == 2 -> 1;
tribonacci(N) ->
    tribonacci(N, 0, 1, 1).

tribonacci(0, A, _, _) -> A;
tribonacci(N, A, B, C) ->
    tribonacci(N - 1, B, C, A + B + C).