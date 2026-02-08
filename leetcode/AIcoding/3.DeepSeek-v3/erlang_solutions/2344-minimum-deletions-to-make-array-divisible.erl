-spec min_operations(Nums :: [integer()], NumsDivide :: [integer()]) -> integer().
min_operations(Nums, NumsDivide) ->
    GCD = lists:foldl(fun gcd/2, hd(NumsDivide), tl(NumsDivide)),
    SortedNums = lists:sort(Nums),
    find_min_deletions(SortedNums, GCD, 0).

gcd(A, 0) -> A;
gcd(A, B) -> gcd(B, A rem B).

find_min_deletions([], _, _) -> -1;
find_min_deletions([Num | Rest], GCD, Count) ->
    case GCD rem Num of
        0 -> Count;
        _ -> find_min_deletions(Rest, GCD, Count + 1)
    end.