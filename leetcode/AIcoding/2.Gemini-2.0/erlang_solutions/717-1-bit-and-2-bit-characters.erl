-module(one_bit_two_bit_characters).
-export([isOneBitCharacter/1]).

isOneBitCharacter(Bits) ->
    isOneBitCharacter(Bits, length(Bits) - 1).

isOneBitCharacter([1], 0) ->
    true;
isOneBitCharacter([0], 0) ->
    true;
isOneBitCharacter([1,0], 1) ->
    true;
isOneBitCharacter([1,1], 1) ->
    true;
isOneBitCharacter([0,0], 1) ->
    false;
isOneBitCharacter([0,1], 1) ->
    false;
isOneBitCharacter(Bits, N) ->
    case lists:nth(N, Bits) of
        0 ->
            true;
        1 ->
            if
                N >= 1 ->
                    true;
                true ->
                    false
            end;
        _ ->
            false
    end.