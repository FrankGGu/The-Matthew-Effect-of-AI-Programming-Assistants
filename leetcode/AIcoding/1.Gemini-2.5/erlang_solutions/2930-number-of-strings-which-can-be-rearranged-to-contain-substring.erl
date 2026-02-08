-module(solution).
-export([number_of_strings/1]).

number_of_strings(N) ->
    MOD = 1000000007,
    Term26 = power(26, N, MOD),
    Term25 = power(25, N, MOD),
    Term24 = power(24, N, MOD),
    Term23 = power(23, N, MOD),

    Ans1 = (Term26 - (3 * Term25 rem MOD) + MOD) rem MOD,
    Ans2 = (Ans1 + (3 * Term24 rem MOD)) rem MOD,
    (Ans2 - Term23 + MOD) rem MOD.

power(_Base, 0, _Mod) -> 1;
power(Base, 1, Mod) -> Base rem Mod;
power(Base, Exp, Mod) ->
    Half = power(Base, Exp div 2, Mod),
    Result = (Half * Half) rem Mod,
    case Exp rem 2 of
        1 -> (Result * Base) rem Mod;
        _ -> Result
    end.