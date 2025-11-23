-module(solution).
-export([solve/1]).

solve(N) ->
    Mod = 1000000007,
    solve_recursive(1, N, 0, 1, 0, Mod).

solve_recursive(I, N, Acc, CurrentPowerOf2, Bits, Mod) when I > N ->
    Acc;
solve_recursive(I, N, Acc, CurrentPowerOf2, Bits, Mod) ->
    NewBits = if I == CurrentPowerOf2 ->
                  Bits + 1
              else
                  Bits
              end,
    NewCurrentPowerOf2 = if I == CurrentPowerOf2 ->
                             CurrentPowerOf2 * 2
                         else
                             CurrentPowerOf2
                         end,
    NextAcc = ((Acc bsl NewBits) + I) rem Mod,
    solve_recursive(I + 1, N, NextAcc, NewCurrentPowerOf2, NewBits, Mod).