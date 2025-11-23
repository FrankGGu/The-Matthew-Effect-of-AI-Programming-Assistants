-module(solution).
-export([concatenatedBinary/1]).

concatenatedBinary(N) ->
    Mod = 1_000_000_007,
    concatenatedBinary_loop(1, N, 0, 0, Mod).

concatenatedBinary_loop(I, N, CurrentResult, NumBits, Mod) when I =< N ->
    NewNumBits =
        case (I band (I - 1)) == 0 of
            true -> NumBits + 1;
            false -> NumBits
        end,
    Shift = 1 bsl NewNumBits,
    NewResult = (CurrentResult * Shift + I) rem Mod,
    concatenatedBinary_loop(I + 1, N, NewResult, NewNumBits, Mod);
concatenatedBinary_loop(_I, _N, CurrentResult, _NumBits, _Mod) ->
    CurrentResult.