-module(solution).
-export([count_ways/1]).

count_ways(N) ->
    Mod = 1000000007,
    Binom = lists:map(fun(X) -> binomial(N, X, Mod) end, lists:seq(0, N)),
    lists:foldl(fun(X, Acc) -> (Acc * X) rem Mod end, 1, Binom).

binomial(N, K, Mod) when K > N -> 0;
binomial(N, K, Mod) when K == 0; K == N -> 1;
binomial(N, K, Mod) ->
    Numerator = factorial(N, Mod),
    Denominator = (factorial(K, Mod) * factorial(N - K, Mod)) rem Mod,
    (Numerator * mod_inverse(Denominator, Mod)) rem Mod.

factorial(0, _) -> 1;
factorial(N, Mod) -> (N * factorial(N - 1, Mod)) rem Mod.

mod_inverse(A, Mod) -> pow(A, Mod - 2, Mod).

pow(_, 0, _) -> 1;
pow(Base, Exp, Mod) -> 
    Result = pow(Base, Exp div 2, Mod),
    if
        Exp rem 2 == 0 -> (Result * Result) rem Mod;
        true -> (Base * Result * Result) rem Mod
    end.