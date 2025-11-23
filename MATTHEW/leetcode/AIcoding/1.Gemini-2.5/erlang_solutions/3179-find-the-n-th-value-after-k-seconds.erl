-module(solution).
-export([solve/2]).

MOD() -> 1000000007.

pow_mod(Base, Exp, Mod) ->
    pow_mod_acc(Base, Exp, Mod, 1).

pow_mod_acc(_Base, 0, _Mod, Acc) -> Acc;
pow_mod_acc(Base, Exp, Mod, Acc) ->
    NewAcc = if Exp rem 2 == 1 -> (Acc * Base) rem Mod;
             else -> Acc
             end,
    pow_mod_acc((Base * Base) rem Mod, Exp div 2, Mod, NewAcc).

inv_mod(N, Mod) ->
    pow_mod(N, Mod - 2, Mod).

nCr_mod_iter(N, R, Mod) ->
    if R < 0 or R > N -> 0;
       R == 0 or R == N -> 1;
       R > N div 2 -> nCr_mod_iter(N, N - R, Mod);
       true ->
            nCr_mod_iter_acc(R, N, Mod, 1)
    end.

nCr_mod_iter_acc(0, _N, _Mod, Acc) -> Acc;
nCr_mod_iter_acc(I, N, Mod, Acc) ->
    Term = (N - I + 1) * inv_mod(I, Mod) rem Mod,
    nCr_mod_iter_acc(I - 1, N, Mod, (Acc * Term) rem Mod).

solve(N, K) ->
    Mod = MOD(),
    N_val = N + K - 1,
    R_val = K,
    nCr_mod_iter(N_val, R_val, Mod).