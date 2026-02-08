-module(solution).
-export([product_except_self/1]).

product_except_self(Array) ->
    N = length(Array),
    Prefix = lists:foldl(fun(X, {Acc, P}) -> {Acc ++ [P], P * X} end, {[], 1}, Array),
    Suffix = lists:foldr(fun(X, {Acc, P}) -> {P * X} end, {[], 1}, Array),
    lists:zipwith(fun({P, S}) -> P * S end, Prefix, Suffix).

zipwith(_, [], []) -> [];
zipwith(F, [H1 | T1], [H2 | T2]) -> [F(H1, H2) | zipwith(F, T1, T2)].