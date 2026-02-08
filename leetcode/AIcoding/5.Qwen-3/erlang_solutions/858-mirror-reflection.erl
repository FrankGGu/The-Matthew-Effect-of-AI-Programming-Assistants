-module(mirror_reflection).
-export([mirror_reflection/2]).

mirror_reflection(P, Q) ->
    L = lcm(P, Q),
    M = L div P,
    N = L div Q,
    case {M rem 2, N rem 2} of
        {0, 1} -> 0;
        {1, 0} -> 1;
        {1, 1} -> 2
    end.

lcm(A, B) ->
    A * B div gcd(A, B).

gcd(A, B) when B == 0 ->
    A;
gcd(A, B) ->
    gcd(B, A rem B).