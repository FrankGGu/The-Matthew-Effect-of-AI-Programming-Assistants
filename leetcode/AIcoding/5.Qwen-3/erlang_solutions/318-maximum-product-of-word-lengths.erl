-module(most_product_of_word_lengths).
-export([max_product/1]).

max_product(Words) ->
    WordLengths = lists:map(fun(W) -> {W, erlang:length(W)} end, Words),
    BitMasks = lists:zipwith(fun({W, L}, I) -> {W, L, bitmask(W, 0)} end, WordLengths, lists:seq(1, length(WordLengths))),
    max_product_helper(BitMasks, 0).

bitmask([], Acc) ->
    Acc;
bitmask([C | Rest], Acc) ->
    Bit = (C - $a) + 1,
    bitmask(Rest, Acc bor (1 bsl Bit)).

max_product_helper([], Max) ->
    Max;
max_product_helper([{W1, L1, M1} | Rest], Max) ->
    CurrentMax = lists:foldl(fun({W2, L2, M2}, Acc) ->
        if
            (M1 band M2) == 0 -> max(Acc, L1 * L2);
            true -> Acc
        end
    end, Max, Rest),
    max_product_helper(Rest, CurrentMax).