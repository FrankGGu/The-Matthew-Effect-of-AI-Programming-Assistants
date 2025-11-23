-module(unequal_triplets).
-export([number_of_unequal_triplets/1]).

number_of_unequal_triplets(Nums) ->
  Len = length(Nums),
  number_of_unequal_triplets_helper(Nums, 0, 0, 0, Len, 0).

number_of_unequal_triplets_helper(_, I, _, _, Len, Count) when I >= Len ->
  Count;
number_of_unequal_triplets_helper(Nums, I, J, K, Len, Count) when K >= Len ->
  number_of_unequal_triplets_helper(Nums, I, J + 1, J + 2, Len, Count);
number_of_unequal_triplets_helper(Nums, I, J, K, Len, Count) when J >= Len - 1 ->
  number_of_unequal_triplets_helper(Nums, I + 1, I + 2, I + 3, Len, Count);
number_of_unequal_triplets_helper(Nums, I, J, K, Len, Count) ->
  case (lists:nth(I + 1, Nums) /= lists:nth(J + 1, Nums)) and
       (lists:nth(I + 1, Nums) /= lists:nth(K + 1, Nums)) and
       (lists:nth(J + 1, Nums) /= lists:nth(K + 1, Nums)) of
    true ->
      number_of_unequal_triplets_helper(Nums, I, J, K + 1, Len, Count + 1);
    false ->
      number_of_unequal_triplets_helper(Nums, I, J, K + 1, Len, Count)
  end.