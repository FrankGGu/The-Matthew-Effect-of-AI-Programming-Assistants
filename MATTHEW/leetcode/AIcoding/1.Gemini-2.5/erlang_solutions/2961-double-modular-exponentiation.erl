-module(solution).
-export([get_double_modular_exponentiation/1]).

get_double_modular_exponentiation(Queries) ->
    [calculate_single_query(Q) || Q <- Queries].

calculate_single_query([A, B, C, M, N]) ->
    X = mod_pow(A, B, M),
    mod_pow(X, C, N).

mod_pow(_Base, _Exp, 1) -> 0;
mod_pow(Base, Exp, Mod) ->
    mod_pow_acc(Base rem Mod, Exp, Mod, 1).

mod_pow_acc(_Base, 0, _Mod, Acc) -> Acc;
mod_pow_acc(Base, Exp, Mod, Acc) ->
    case Exp rem 2 of
        1 ->
            NewAcc = (Acc * Base) rem Mod,
            NewBase = (Base * Base) rem Mod,
            mod_pow_acc(NewBase, Exp div 2, Mod, NewAcc);
        0 ->
            NewBase = (Base * Base) rem Mod,
            mod_pow_acc(NewBase, Exp div 2, Mod, Acc)
    end.