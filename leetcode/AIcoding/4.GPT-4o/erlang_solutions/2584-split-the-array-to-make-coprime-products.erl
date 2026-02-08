-module(solution).
-export([find_valid_split/1]).

find_valid_split(A) ->
    case valid_split(A) of
        true -> 1;
        false -> 0
    end.

valid_split([]) -> false;
valid_split([_]) -> false;
valid_split(A) ->
    {G, B} = lists:foldl(fun(X, {G, B}) -> {gcd(G, X), B * X} end, {hd(A), 1}, A),
    lists:foldl(fun(X, Acc) -> gcd(Acc, X) end, 1, A) /= 1.

gcd(A, 0) -> A;
gcd(A, B) -> gcd(B, A rem B.