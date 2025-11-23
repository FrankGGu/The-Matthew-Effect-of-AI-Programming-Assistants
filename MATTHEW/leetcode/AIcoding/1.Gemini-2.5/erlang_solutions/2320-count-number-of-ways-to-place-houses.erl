-module(solution).
-export([countHousePlacements/1]).

countHousePlacements(N) ->
    Mod = 1000000007,
    WaysOneSide = calculate_fib_n_plus_1(N, Mod),
    (WaysOneSide * WaysOneSide) rem Mod.

calculate_fib_n_plus_1(N, Mod) ->
    calculate_fib_loop_iter(N, 1, 1, Mod).

calculate_fib_loop_iter(0, _A, B, _Mod) ->
    B;
calculate_fib_loop_iter(Count, A, B, Mod) when Count > 0 ->
    NextFib = (A + B) rem Mod,
    calculate_fib_loop_iter(Count - 1, B, NextFib, Mod).