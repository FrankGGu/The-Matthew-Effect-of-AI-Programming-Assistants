-module(min_k_consecutive_bit_flips).
-export([minKBitFlips/2]).

minKBitFlips(A, K) ->
    minKBitFlips(A, K, 0, 0).

minKBitFlips([], _, Flips, _) ->
    Flips;
minKBitFlips(A, K, Flips, Acc) ->
    minKBitFlips(A, K, Flips, Acc, []).

minKBitFlips([H | T], K, Flips, Acc, Flipped) ->
    case lists:len(Flipped) > 0 andalso lists:nth(1,Flipped) =:= Acc of
        true ->
            minKBitFlips(T, K, Flips, Acc, lists:sublist(Flipped, 2, lists:len(Flipped)-1));
        false ->
            case (H + Acc) rem 2 of
                0 ->
                    case lists:len(T) < K -1 of
                        true -> -1;
                        false ->
                            minKBitFlips(T, K, Flips + 1, (Acc + 1) rem 2, lists:seq(1,K-1));
                    end;
                1 ->
                    minKBitFlips(T, K, Flips, Acc, lists:seq(1,lists:len(Flipped)));
            end
    end.