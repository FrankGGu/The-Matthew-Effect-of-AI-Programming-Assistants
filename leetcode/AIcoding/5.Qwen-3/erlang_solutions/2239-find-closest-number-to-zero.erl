-module(solution).
-export([closestToZero/1]).

closestToZero(Nums) ->
    lists:foldl(fun(X, Acc) -> compare(X, Acc) end, hd(Nums), tl(Nums)).

compare(A, B) when A < B -> A;
compare(A, B) when A > B -> B;
compare(A, B) when A == B -> A.