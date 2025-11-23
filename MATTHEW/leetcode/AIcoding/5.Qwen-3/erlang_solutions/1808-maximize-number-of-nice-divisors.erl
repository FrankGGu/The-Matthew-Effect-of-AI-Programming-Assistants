-module(solution).
-export([maxNiceDivisors/1]).

maxNiceDivisors(N) ->
    mod = 1000000007,
    if
        N == 1 -> 1;
        true ->
            Factors = factorize(N),
            lists:foldl(fun({p, e}, Acc) -> (Acc * pow(p, e, mod)) rem mod end, 1, Factors)
    end.

factorize(N) ->
    factorize(N, 2, []).

factorize(1, _, Acc) ->
    Acc;
factorize(N, D, Acc) when N rem D == 0 ->
    Count = count_factor(N, D, 0),
    factorize(N div (math:pow(D, Count)), D + 1, [{D, Count} | Acc]);
factorize(N, D, Acc) ->
    factorize(N, D + 1, Acc).

count_factor(N, D, Count) ->
    if
        N rem D == 0 -> count_factor(N div D, D, Count + 1);
        true -> Count
    end.

pow(_, 0, _) -> 1;
pow(Base, Exp, Mod) ->
    pow(Base, Exp, Mod, 1).

pow(_, 0, _, Acc) -> Acc;
pow(Base, Exp, Mod, Acc) ->
    case Exp rem 2 of
        0 -> pow(Base * Base rem Mod, Exp div 2, Mod, Acc);
        1 -> pow(Base * Base rem Mod, Exp div 2, Mod, Acc * Base rem Mod)
    end.