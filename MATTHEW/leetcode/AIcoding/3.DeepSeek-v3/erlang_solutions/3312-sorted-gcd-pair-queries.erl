-module(solution).
-export([handle_query/3]).

-spec handle_query(Nums :: [integer()], Queries :: [[integer()]]) -> [integer()].
handle_query(Nums, Queries) ->
    lists:map(fun([X, Y]) -> gcd(lists:nth(X, Nums), lists:nth(Y, Nums)) end, Queries).

gcd(A, 0) -> A;
gcd(A, B) -> gcd(B, A rem B).