-module(mirror_reflection).
-export([mirrorReflection/2]).

mirrorReflection(P, Q) ->
    G = gcd(P, Q),
    M = P div G,
    N = Q div G,

    if
        N rem 2 == 1 ->
            if
                M rem 2 == 1 ->
                    1;
                true ->
                    2
            end;
        true ->
            0
    end.

gcd(A, 0) -> A;
gcd(A, B) -> gcd(B, A rem B).