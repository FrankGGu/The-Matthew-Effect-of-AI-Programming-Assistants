-module(max_len_subarray_positive_product).
-export([max_len/1]).

max_len(Nums) ->
    max_len(Nums, 0, 0, 0, 0).

max_len([], MaxLen, _, _, _) ->
    MaxLen;
max_len([Num | Rest], MaxLen, PosLen, NegLen, Start) ->
    case Num of
        0 ->
            max_len(Rest, MaxLen, 0, 0, Start + 1);
        N when N > 0 ->
            NewPosLen = PosLen + 1,
            NewNegLen = if NegLen > 0 then NegLen + 1 else 0 end,
            NewMaxLen = max(MaxLen, NewPosLen),
            max_len(Rest, NewMaxLen, NewPosLen, NewNegLen, Start + 1);
        _ ->
            NewPosLen = if NegLen > 0 then NegLen + 1 else 0 end,
            NewNegLen = PosLen + 1,
            NewMaxLen = if NewPosLen > 0 then max(MaxLen, NewPosLen) else MaxLen end,
            max_len(Rest, NewMaxLen, NewPosLen, NewNegLen, Start + 1)
    end.