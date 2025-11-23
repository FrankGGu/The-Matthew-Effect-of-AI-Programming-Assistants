-module(max_product_palindromes).
-export([max_product/1]).

max_product(S) ->
  N = length(S),
  Masks = lists:seq(0, 1 bsl N - 1),
  ValidMasks = lists:filter(fun(Mask) -> is_palindrome_subsequence(S, Mask) end, Masks),
  MaxProduct = lists:foldl(fun(Mask1, Acc) ->
                                  MaxProductForMask1 = lists:foldl(fun(Mask2, Acc2) ->
                                                                        if Mask1 band Mask2 == 0 ->
                                                                          Len1 = count_set_bits(Mask1),
                                                                          Len2 = count_set_bits(Mask2),
                                                                          max(Acc2, Len1 * Len2)
                                                                        else
                                                                          Acc2
                                                                        end
                                                                    end, 0, ValidMasks),
                                  max(Acc, MaxProductForMask1)
                              end, 0, ValidMasks),
  MaxProduct.

is_palindrome_subsequence(S, Mask) ->
  Subsequence = extract_subsequence(S, Mask),
  Subsequence = lists:reverse(Subsequence),
  extract_subsequence(S, Mask) == Subsequence.

extract_subsequence(S, Mask) ->
  extract_subsequence(S, Mask, 0, []).

extract_subsequence([], _, _, Acc) ->
  lists:reverse(Acc);
extract_subsequence([H | T], Mask, Index, Acc) ->
  if Mask band (1 bsl Index) > 0 ->
    extract_subsequence(T, Mask, Index + 1, [H | Acc])
  else
    extract_subsequence(T, Mask, Index + 1, Acc)
  end.

count_set_bits(Mask) ->
  count_set_bits(Mask, 0).

count_set_bits(0, Count) ->
  Count;
count_set_bits(Mask, Count) ->
  count_set_bits(Mask band (Mask - 1), Count + 1).