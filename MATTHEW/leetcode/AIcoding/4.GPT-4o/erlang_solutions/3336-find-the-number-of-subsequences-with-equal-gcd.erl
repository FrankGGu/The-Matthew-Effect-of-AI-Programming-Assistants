-module(solution).
-export([num_subseq/2]).

num_subseq(List, K) ->
    Sorted = lists:sort(List),
    Count = length(Sorted),
    GCDs = lists:map(fun(X) -> gcd(X, K) end, Sorted),
    find_subsequences(GCDs, K, Count).

find_subsequences(GCDs, K, Count) ->
    lists:foldl(fun(GCD, Acc) ->
        if GCD == K -> Acc + 1; true -> Acc end
    end, 0, GCDs).

gcd(A, 0) -> A;
gcd(A, B) -> gcd(B, A rem B).