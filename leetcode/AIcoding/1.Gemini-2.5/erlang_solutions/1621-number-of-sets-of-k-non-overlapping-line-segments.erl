-module(solution).
-export([number_of_sets/2]).

MOD() -> 1000000007.

-spec power(integer(), integer()) -> integer().
power(Base, Exp) ->
    power(Base, Exp, 1, MOD()).

power(_Base, 0, Acc, _Mod) -> Acc;
power(Base, Exp, Acc, Mod) ->
    NewAcc = if Exp rem 2 == 1 -> (Acc * Base) rem Mod;
             true -> Acc
             end,
    NewBase = (Base * Base) rem Mod,
    power(NewBase, Exp div 2, NewAcc, Mod).

-spec mod_inverse(integer()) -> integer().
mod_inverse(N) ->
    power(N, MOD() - 2).

-spec nCr(integer(), integer()) -> integer().
nCr(N_val, R_val) when R_val < 0; R_val > N_val -> 0;
nCr(N_val, R_val) ->
    Mod = MOD(),
    R_min = min(R_val, N_val - R_val),
    if R_min == 0 -> 1;
       true ->
            Numerator = lists:foldl(fun(I, Acc) -> (Acc * (N_val - I + 1)) rem Mod end, 1, lists:seq(1, R_min)),
            Denominator = lists:foldl(fun(I, Acc) -> (Acc * I) rem Mod end, 1, lists:seq(1, R_min)),
            (Numerator * mod_inverse(Denominator)) rem Mod
    end.

-spec number_of_sets(integer(), integer()) -> integer().
number_of_sets(N, K) ->
    nCr(N + 1, 2 * K).