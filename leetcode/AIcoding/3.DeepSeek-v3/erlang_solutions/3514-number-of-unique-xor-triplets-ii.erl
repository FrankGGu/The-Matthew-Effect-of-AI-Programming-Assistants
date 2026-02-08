-module(solution).
-export([count_triplets/1]).

count_triplets(Nums) ->
    N = length(Nums),
    Count = 0,
    count_triplets(Nums, N, Count).

count_triplets(_, 0, Count) -> Count;
count_triplets(Nums, I, Count) ->
    J = I - 1,
    count_triplets(Nums, J, Count, J).

count_triplets(_, _, Count, 0) -> Count;
count_triplets(Nums, I, Count, J) ->
    K = J - 1,
    count_triplets(Nums, I, J, Count, K).

count_triplets(_, _, _, Count, 0) -> Count;
count_triplets(Nums, I, J, Count, K) ->
    A = lists:nth(I, Nums),
    B = lists:nth(J, Nums),
    C = lists:nth(K, Nums),
    case (A bxor B bxor C) == 0 of
        true -> count_triplets(Nums, I, J, Count + 1, K - 1);
        false -> count_triplets(Nums, I, J, Count, K - 1)
    end.