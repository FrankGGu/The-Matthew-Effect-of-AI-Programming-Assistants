-spec count_quadruplets(Nums :: [integer()]) -> integer().
count_quadruplets(Nums) ->
    N = length(Nums),
    Count = 0,
    count_quadruplets(Nums, N, Count).

count_quadruplets(_, N, Count) when N < 4 ->
    Count;
count_quadruplets(Nums, N, Count) ->
    count_quadruplets(Nums, N, 0, 1, 2, 3, Count).

count_quadruplets(Nums, N, I, J, K, L, Count) when L < N ->
    case (lists:nth(I+1, Nums) < lists:nth(K+1, Nums) andalso (lists:nth(J+1, Nums) < lists:nth(L+1, Nums) of
        true ->
            count_quadruplets(Nums, N, I, J, K, L + 1, Count + 1);
        false ->
            count_quadruplets(Nums, N, I, J, K, L + 1, Count)
    end;
count_quadruplets(Nums, N, I, J, K, L, Count) when K < N - 1 ->
    count_quadruplets(Nums, N, I, J, K + 1, K + 2, Count);
count_quadruplets(Nums, N, I, J, K, L, Count) when J < N - 2 ->
    count_quadruplets(Nums, N, I, J + 1, J + 2, J + 3, Count);
count_quadruplets(Nums, N, I, J, K, L, Count) when I < N - 3 ->
    count_quadruplets(Nums, N, I + 1, I + 2, I + 3, I + 4, Count);
count_quadruplets(_, _, _, _, _, _, Count) ->
    Count.