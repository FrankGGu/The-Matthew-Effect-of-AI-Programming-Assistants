-module(sorted_gcd_pair_queries).
-export([solve/2]).

solve(Nums, Queries) ->
    SortedNums = lists:sort(Nums),
    [gcd_count(SortedNums, Q) || Q <- Queries].

gcd_count(Nums, [First, Second]) ->
    F = lists:nth(First + 1, Nums),
    S = lists:nth(Second + 1, Nums),
    gcd(F, S).

gcd(A, 0) -> A;
gcd(0, B) -> B;
gcd(A, B) -> gcd(B, A rem B).