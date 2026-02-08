-module(minimum_number_of_k_consecutive_bit_flips).
-export([minKBitFlips/2]).

minKBitFlips(Bits, K) ->
    N = length(Bits),
    Flips = 0,
    IsFlipping = array:new(N, {default, false}),
    FlipCount = 0,
    minKBitFlips(Bits, K, 0, Flips, IsFlipping, FlipCount).

minKBitFlips(_, _, N, _, _, _) when N >= length(Bits) -> FlipCount;
minKBitFlips(Bits, K, I, Flips, IsFlipping, FlipCount) ->
    CurrentBit = lists:nth(I + 1, Bits),
    IsFlippingNow = array:get(I, IsFlipping),
    if
        IsFlippingNow == true ->
            NewFlipCount = FlipCount + 1,
            NewIsFlipping = array:set(I + K, false, IsFlipping),
            minKBitFlips(Bits, K, I + 1, Flips, NewIsFlipping, NewFlipCount);
        CurrentBit == 0 ->
            if
                I + K > length(Bits) ->
                    FlipCount;
                true ->
                    NewIsFlipping = array:set(I, true, IsFlipping),
                    minKBitFlips(Bits, K, I + 1, Flips, NewIsFlipping, FlipCount)
            end;
        true ->
            minKBitFlips(Bits, K, I + 1, Flips, IsFlipping, FlipCount)
    end.