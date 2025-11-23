-module(solution).
-export([tribonacci/1]).

tribonacci(0) -> 0;
tribonacci(1) -> 1;
tribonacci(2) -> 1;
tribonacci(N) when N > 2 ->
    tribonacci_iter(N, 0, 1, 1, 2).

tribonacci_iter(TargetN, T_prev3, T_prev2, T_prev1, CurrentIndex) when CurrentIndex == TargetN ->
    T_prev1;
tribonacci_iter(TargetN, T_prev3, T_prev2, T_prev1, CurrentIndex) ->
    NextT = T_prev3 + T_prev2 + T_prev1,
    tribonacci_iter(TargetN, T_prev2, T_prev1, NextT, CurrentIndex + 1).