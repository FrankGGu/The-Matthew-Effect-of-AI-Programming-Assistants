-module(solution).
-export([mirrorReflection/2]).

mirrorReflection(P, Q) ->
    Gcd = gcd(P, Q),
    M = P div Gcd,
    N = Q div Gcd,
    case {M rem 2, N rem 2} of
        {1, 0} -> 0;
        {1, 1} -> 1;
        {0, 1} -> 2
    end.

gcd(A, 0) -> A;
gcd(A, B) -> gcd(B, A rem B).