-module(count_special_quadruplets).
-export([count_quadruplets/1]).

count_quadruplets(Nums) ->
    Len = length(Nums),
    count_quadruplets_helper(Nums, 0, 1, 2, 3, 0, Len).

count_quadruplets_helper(_Nums, I, _J, _K, _L, Count, Len) when I >= Len - 3 ->
    Count;
count_quadruplets_helper(_Nums, I, J, _K, _L, Count, Len) when J >= Len - 2 ->
    count_quadruplets_helper(_Nums, I + 1, I + 2, I + 3, I + 4, Count, Len);
count_quadruplets_helper(_Nums, I, J, K, _L, Count, Len) when K >= Len - 1 ->
    count_quadruplets_helper(_Nums, I, J + 1, J + 2, J + 3, Count, Len);
count_quadruplets_helper(_Nums, I, J, K, L, Count, Len) when L >= Len ->
    count_quadruplets_helper(_Nums, I, J, K + 1, K + 2, Count, Len);
count_quadruplets_helper(Nums, I, J, K, L, Count, Len) ->
    if
        lists:nth(I + 1, Nums) + lists:nth(J + 1, Nums) + lists:nth(K + 1, Nums) =:= lists:nth(L + 1, Nums) ->
            count_quadruplets_helper(Nums, I, J, K, L + 1, Count + 1, Len);
        true ->
            count_quadruplets_helper(Nums, I, J, K, L + 1, Count, Len)
    end.