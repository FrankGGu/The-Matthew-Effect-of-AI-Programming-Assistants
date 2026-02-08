-module(simplified_fractions).
-export([find_simplified_fractions/1]).

find_simplified_fractions(N) ->
    find_simplified_fractions(N, 1, []).

find_simplified_fractions(N, N, Acc) ->
    lists:sort(Acc);
find_simplified_fractions(N, K, Acc) ->
    find_simplified_fractions(N, K + 1, lists:foldl(fun(I, A) -> 
        if
            math:gcd(K, I) == 1 -> [{K, I} | A];
            true -> A
        end
    end, Acc, lists:seq(1, N))).

math:gcd(A, B) ->
    math:gcd(A, B, 0).

math:gcd(A, B, _R) when B == 0 ->
    A;
math:gcd(A, B, R) ->
    math:gcd(B, R, A rem B).