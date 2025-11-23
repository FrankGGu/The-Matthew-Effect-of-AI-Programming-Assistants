-spec find_gcd(Nums :: [integer()]) -> integer().
find_gcd(Nums) ->
    Min = lists:min(Nums),
    Max = lists:max(Nums),
    gcd(Min, Max).

gcd(A, 0) -> A;
gcd(A, B) -> gcd(B, A rem B).