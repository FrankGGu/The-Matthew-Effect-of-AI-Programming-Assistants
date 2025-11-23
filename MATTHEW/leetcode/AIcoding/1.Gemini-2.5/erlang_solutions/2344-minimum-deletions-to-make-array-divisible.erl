-module(solution).
-export([min_deletions/2]).

gcd(A, 0) -> A;
gcd(A, B) -> gcd(B, A rem B).

list_gcd([H | T]) -> lists:foldl(fun gcd/2, H, T).

min_deletions(Nums, NumsDivide) ->
    OverallGCD = list_gcd(NumsDivide),
    SortedNums = lists:sort(Nums),
    find_min_divisor(SortedNums, OverallGCD, 0).

find_min_divisor([], _OverallGCD, _Count) ->
    -1;
find_min_divisor([H | T], OverallGCD, Count) ->
    if
        OverallGCD rem H == 0 ->
            Count;
        true ->
            find_min_divisor(T, OverallGCD, Count + 1)
    end.