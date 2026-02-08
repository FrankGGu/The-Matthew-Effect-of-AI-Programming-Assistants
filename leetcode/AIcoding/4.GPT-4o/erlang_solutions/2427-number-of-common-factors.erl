-module(solution).
-export([commonFactors/2]).

commonFactors(A, B) ->
    GCD = gcd(A, B),
    count_factors(GCD, 1).

gcd(X, 0) -> X;
gcd(X, Y) -> gcd(Y, X rem Y).

count_factors(N, I) when I > N -> 0;
count_factors(N, I) ->
    Count = if N rem I == 0 -> 1; true -> 0 end,
    Count + count_factors(N, I + 1).