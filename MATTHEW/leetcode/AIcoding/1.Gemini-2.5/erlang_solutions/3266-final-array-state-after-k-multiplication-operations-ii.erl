-module(solution).
-export([finalArrayState/3]).

power(Base, Exp, Mod) when Mod == 1 ->
    0;
power(Base, Exp, Mod) when Exp == 0 ->
    1;
power(Base, Exp, Mod) ->
    Result = power((Base * Base) rem Mod, Exp div 2, Mod),
    case Exp rem 2 of
        1 -> (Result * Base) rem Mod;
        0 -> Result
    end.

finalArrayState(Nums, K, Modulo) ->
    lists:map(fun(X) -> power(X, K, Modulo) end, Nums).