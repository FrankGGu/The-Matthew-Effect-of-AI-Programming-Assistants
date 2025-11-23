-module(solution).
-export([string_count/1]).

string_count(N) ->
    Mod = 1000000007,
    Total = pow(26, N, Mod),
    Invalid = (pow(25, N, Mod) + pow(25, N, Mod) + pow(25, N, Mod) rem Mod,
    Overlap = (pow(24, N, Mod) + pow(24, N, Mod) + pow(24, N, Mod)) rem Mod,
    Invalid2 = (Invalid - Overlap + Mod) rem Mod,
    (Total - Invalid2 + Mod) rem Mod.

pow(_, 0, _) -> 1;
pow(A, B, Mod) ->
    if
        B rem 2 == 0 ->
            Half = pow(A, B div 2, Mod),
            (Half * Half) rem Mod;
        true ->
            (A * pow(A, B - 1, Mod)) rem Mod
    end.