-module(solution).
-export([maxProduct/1]).

maxProduct(Words) ->
    MaskToMaxLengthMap = build_masks_and_lengths(Words),
    Pairs = maps:to_list(MaskToMaxLengthMap),
    find_max_product_iter(Pairs, 0).

build_masks_and_lengths(Words) ->
    lists:foldl(fun(Word, AccMap) ->
        Mask = calculate_mask(Word),
        Length = length(Word),
        maps:update_with(Mask, fun(ExistingLen) -> max(ExistingLen, Length) end, Length, AccMap)
    end, #{}, Words).

calculate_mask(Word) ->
    lists:foldl(fun(Char, AccMask) ->
        AccMask bor (1 bsl (Char - $a))
    end, 0, Word).

find_max_product_iter([], MaxProduct) -> MaxProduct;
find_max_product_iter([{Mask1, Len1} | RestPairs], CurrentMaxProduct) ->
    NewMaxProduct = lists:foldl(fun({Mask2, Len2}, AccMax) ->
        if
            (Mask1 band Mask2) == 0 -> max(AccMax, Len1 * Len2);
            true -> AccMax
        end
    end, CurrentMaxProduct, RestPairs),
    find_max_product_iter(RestPairs, NewMaxProduct).