-module(solution).
-export([hasGroupsSizeX/1]).

hasGroupsSizeX(Deck) ->
    Counts = lists:foldl(fun(X, Acc) -> maps:update_with(X, fun(Count) -> Count + 1 end, 1, Acc) end, map:new(), Deck),
    Gcd = lists:foldl(fun({_, Count}, Acc) -> gcd(Count, Acc) end, 0, maps:to_list(Counts)),
    Gcd >= 2.

gcd(A, 0) -> A;
gcd(A, B) -> gcd(B, A rem B).