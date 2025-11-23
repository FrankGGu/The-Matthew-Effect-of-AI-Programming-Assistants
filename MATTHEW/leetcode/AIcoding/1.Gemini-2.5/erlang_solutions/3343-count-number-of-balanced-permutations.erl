-module(solution).
-export([countBalancedPermutations/1]).

MOD = 1000000007.

power(_, 0, _, Acc) -> Acc;
power(Base, Exp, Mod, Acc) ->
    case Exp rem 2 of
        1 -> power((Base * Base) rem Mod, Exp div 2, Mod, (Acc * Base) rem Mod);
        0 -> power((Base * Base) rem Mod, Exp div 2, Mod, Acc)
    end.

mod_power(Base, Exp, Mod) ->
    power(Base, Exp, Mod, 1).

mod_inverse(N, M) ->
    mod_power(N, M - 2, M).

nCr_mod_p(N, R, P) when R < 0; R > N -> 0;
nCr_mod_p(N, R, P) ->
    R_eff = min(R, N - R),

    Numerator = lists:foldl(fun(I, Acc) -> (Acc * I) rem P end, 1, lists:seq(N - R_eff + 1, N)),

    Denominator = lists:foldl(fun(I, Acc) -> (Acc * I) rem P end, 1, lists:seq(1, R_eff)),

    (Numerator * mod_inverse(Denominator, P)) rem P.

countBalancedPermutations(N) ->
    N_2 = 2 * N,
    BinomialCoefficient = nCr_mod_p(N_2, N, MOD),

    InverseNPlus1 = mod_inverse(N + 1, MOD),

    (BinomialCoefficient * InverseNPlus1) rem MOD.