-spec max_num(Sum :: integer(), K :: integer()) -> integer().
max_num(Sum, K) ->
    Binary = integer_to_binary(Sum),
    Len = byte_size(Binary),
    Max = binary:decode_unsigned(Binary, little),
    find_max(0, Max, K, Len).

find_max(Low, High, K, Len) when Low =< High ->
    Mid = (Low + High) div 2,
    MidBin = integer_to_binary(Mid, 2),
    MidLen = byte_size(MidBin),
    Padded = pad_binary(MidBin, Len),
    Price = calculate_price(Padded),
    if
        Price =< K ->
            find_max(Mid + 1, High, K, Len);
        true ->
            find_max(Low, Mid - 1, K, Len)
    end;
find_max(Low, _High, _K, _Len) ->
    Low - 1.

pad_binary(Bin, Len) ->
    case byte_size(Bin) of
        Len -> Bin;
        Size when Size < Len ->
            <<Bin/binary, 0:((Len - Size) * 8)>>
    end.

calculate_price(Bin) ->
    calculate_price(Bin, 0, 0).

calculate_price(<<>>, _Pos, Acc) ->
    Acc;
calculate_price(<<Bit:1, Rest/bitstring>>, Pos, Acc) ->
    NewAcc = case Bit of
        1 -> Acc + (Pos + 1);
        0 -> Acc
    end,
    calculate_price(Rest, Pos + 1, NewAcc).