-spec mirror_reflection(P :: integer(), Q :: integer()) -> integer().
mirror_reflection(P, Q) ->
    G = gcd(P, Q),
    K = P div G,
    M = Q div G,
    case {K rem 2, M rem 2} of
        {1, 1} -> 1;
        {1, 0} -> 0;
        {0, 1} -> 2
    end.

gcd(A, 0) -> A;
gcd(A, B) -> gcd(B, A rem B).