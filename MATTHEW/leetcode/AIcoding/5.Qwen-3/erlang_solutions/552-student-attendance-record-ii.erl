-module(solution).
-export([check_record/1]).

check_record(N) ->
    Mod = 1000000007,
    {A, B, C, D, E} = dp(N, Mod),
    (A + B + C + D + E) rem Mod.

dp(0, _) -> {1, 0, 0, 0, 0};
dp(N, Mod) ->
    {A_prev, B_prev, C_prev, D_prev, E_prev} = dp(N-1, Mod),
    A = (A_prev + B_prev + C_prev) rem Mod,
    B = (A_prev) rem Mod,
    C = (B_prev) rem Mod,
    D = (C_prev + D_prev + E_prev) rem Mod,
    E = (D_prev) rem Mod,
    {A, B, C, D, E}.