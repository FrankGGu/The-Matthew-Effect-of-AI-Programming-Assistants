-module(mirror_reflection).
-export([mirror_reflection/1]).

mirror_reflection(P, Q) ->
    case gcd(P, Q) of
        Gcd ->
            P1 = P div Gcd,
            Q1 = Q div Gcd,
            case P1 rem 2 of
                1 ->
                    case Q1 rem 2 of
                        0 -> 0;
                        1 -> 1
                    end;
                0 -> 2
            end
    end.

gcd(A, 0) -> A;
gcd(A, B) -> gcd(B, A rem B).