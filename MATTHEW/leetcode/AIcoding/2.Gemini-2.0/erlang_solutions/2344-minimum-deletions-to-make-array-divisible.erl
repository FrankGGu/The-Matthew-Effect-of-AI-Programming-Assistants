-module(minimum_deletions).
-export([min_deletions/1, gcd/2]).

min_deletions(Nums, NumsDivide) ->
    Gcd = lists:foldl(fun(X, Acc) -> gcd(X, Acc) end, lists:hd(NumsDivide), lists:tl(NumsDivide)),
    SortedNums = lists:sort(Nums),
    min_deletions_helper(SortedNums, Gcd, 0).

min_deletions_helper([], _, Count) ->
    Count;
min_deletions_helper([H|T], Gcd, Count) ->
    if Gcd rem H == 0 ->
        Count;
    true ->
        min_deletions_helper(T, Gcd, Count + 1)
    end.

gcd(A, 0) ->
    A;
gcd(0, B) ->
    B;
gcd(A, B) ->
    gcd(B, A rem B).