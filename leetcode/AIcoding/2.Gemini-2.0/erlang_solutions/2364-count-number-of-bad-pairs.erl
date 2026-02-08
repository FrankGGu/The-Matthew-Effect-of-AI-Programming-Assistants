-module(bad_pairs).
-export([count_bad_pairs/1]).

count_bad_pairs(Nums) ->
    N = length(Nums),
    count_bad_pairs(Nums, 0, N, 0).

count_bad_pairs(_Nums, I, N, Count) when I >= N ->
    Count;
count_bad_pairs(Nums, I, N, Count) ->
    count_bad_pairs_helper(Nums, I, I + 1, N, Count).

count_bad_pairs_helper(_Nums, I, J, N, Count) when J >= N ->
    count_bad_pairs(Nums, I + 1, N, Count);
count_bad_pairs_helper(Nums, I, J, N, Count) ->
    case lists:nth(I + 1, Nums) - lists:nth(J + 1, Nums) =/= I - J of
        true ->
            count_bad_pairs_helper(Nums, I, J + 1, N, Count + 1);
        false ->
            count_bad_pairs_helper(Nums, I, J + 1, N, Count)
    end.