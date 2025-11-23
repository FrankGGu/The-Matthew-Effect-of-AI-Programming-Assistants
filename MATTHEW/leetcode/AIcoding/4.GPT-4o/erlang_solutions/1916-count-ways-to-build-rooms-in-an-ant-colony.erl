-module(solution).
-export([count_ways/1]).

count_ways(R) when R >= 1 ->
    Mod = 10^9 + 7,
    N = R - 1,
    Factorial = lists:foldl(fun(X, Acc) -> (Acc * X) rem Mod end, 1, lists:seq(1, N)),
    Inverse = mod_inverse(Factorial, Mod),
    (Factorial * Inverse * Inverse) rem Mod.

mod_inverse(A, M) ->
    {G, X, _} = extended_gcd(A, M),
    if G /= 1 -> 0; true -> (X rem M + M) rem M end.

extended_gcd(A, 0) -> {A, 1, 0};
extended_gcd(A, B) ->
    {G, X1, Y1} = extended_gcd(B, A rem B),
    {G, Y1, X1 - (A div B) * Y1}.