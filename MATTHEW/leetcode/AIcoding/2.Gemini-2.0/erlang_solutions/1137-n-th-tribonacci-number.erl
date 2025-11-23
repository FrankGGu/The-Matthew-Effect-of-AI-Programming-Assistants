-module(tribonacci).
-export([tribonacci/1]).

tribonacci(N) ->
  tribonacci(N, 0, 1, 1).

tribonacci(0, A, _B, _C) ->
  A;
tribonacci(1, _A, B, _C) ->
  B;
tribonacci(2, _A, _B, C) ->
  C;
tribonacci(N, A, B, C) ->
  tribonacci(N - 1, B, C, A + B + C).