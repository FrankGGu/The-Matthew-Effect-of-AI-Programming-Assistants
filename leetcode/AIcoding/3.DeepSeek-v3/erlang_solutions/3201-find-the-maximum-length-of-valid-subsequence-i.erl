-spec max_subsequence_length(Nums :: [integer()], K :: integer()) -> integer().
max_subsequence_length(Nums, K) ->
    solve(Nums, K, 0, 0).

solve([], _, Len, MaxLen) ->
    max(Len, MaxLen);
solve([H | T], K, Len, MaxLen) when H =< K ->
    solve(T, K - H, Len + 1, MaxLen);
solve([_ | T], K, Len, MaxLen) ->
    solve(T, K, Len, max(Len, MaxLen)).