-spec get_max_len(Nums :: [integer()]) -> integer().
get_max_len(Nums) ->
    get_max_len(Nums, 0, 0, 0, 0).

get_max_len([], _, _, _, MaxLen) -> MaxLen;
get_max_len([Num | Rest], PosLen, NegLen, FirstNeg, MaxLen) ->
    if
        Num == 0 ->
            get_max_len(Rest, 0, 0, 0, MaxLen);
        Num > 0 ->
            NewPosLen = PosLen + 1,
            NewNegLen = if NegLen > 0 -> NegLen + 1; true -> 0 end,
            NewMaxLen = max(MaxLen, NewPosLen),
            get_max_len(Rest, NewPosLen, NewNegLen, FirstNeg, NewMaxLen);
        true ->
            NewFirstNeg = if FirstNeg == 0 -> NegLen + 1; true -> FirstNeg end,
            NewNegLen = PosLen + 1,
            NewPosLen = if NegLen > 0 -> NegLen + 1; true -> 0 end,
            NewMaxLen = max(MaxLen, NewPosLen),
            get_max_len(Rest, NewPosLen, NewNegLen, NewFirstNeg, NewMaxLen)
    end.