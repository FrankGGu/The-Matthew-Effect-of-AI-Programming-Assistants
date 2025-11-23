-module(number_of_unique_xor_triplets_i).
-export([count_triplets/1]).

count_triplets(Nums) ->
    count_triplets(Nums, 0).

count_triplets([], Acc) ->
    Acc;
count_triplets(Nums, Acc) ->
    Len = length(Nums),
    count_triplets(Nums, 0, 0, 0, Len, Acc).

count_triplets(_Nums, I, J, K, Len, Acc) when I >= Len ->
    Acc;
count_triplets(Nums, I, J, K, Len, Acc) when J >= Len ->
    count_triplets(Nums, I + 1, I + 2, I + 3, Len, Acc);
count_triplets(Nums, I, J, K, Len, Acc) when K >= Len ->
    count_triplets(Nums, I, J + 1, J + 2, Len, Acc);
count_triplets(Nums, I, J, K, Len, Acc) ->
    case (lists:nth(I + 1, Nums) bxor lists:nth(J + 1, Nums) bxor lists:nth(K + 1, Nums)) =:= 0 of
        true ->
            count_triplets(Nums, I, J, K + 1, Len, Acc + 1);
        false ->
            count_triplets(Nums, I, J, K + 1, Len, Acc)
    end.