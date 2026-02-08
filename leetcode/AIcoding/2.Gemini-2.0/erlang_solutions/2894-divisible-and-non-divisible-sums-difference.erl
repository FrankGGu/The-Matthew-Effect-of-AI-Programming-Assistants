-module(divisible_sums).
-export([solve/3]).

solve(N, M, X) ->
  Divisible_Sum = (N div M) * M,
  Non_Divisible_Sum = (N * (N + 1) div 2) - (N div M) * (M + N) div 2,
  Non_Divisible_Sum - Divisible_Sum.