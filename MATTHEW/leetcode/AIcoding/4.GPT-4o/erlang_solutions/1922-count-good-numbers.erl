-module(solution).
-export([count_good_numbers/1]).

count_good_numbers(N) ->
    Mod = 1000000007,
    EvenCount = pow(5, (N + 1) div 2, Mod),
    OddCount = pow(4, N div 2, Mod),
    (EvenCount * OddCount) rem Mod.

pow(_, 0, _) -> 1;
pow(base, exp, mod) ->
    Res = pow(base, exp div 2, mod),
    Res1 = (Res * Res) rem mod,
    case exp rem 2 of
        0 -> Res1;
        _ -> (Res1 * base) rem mod
    end.