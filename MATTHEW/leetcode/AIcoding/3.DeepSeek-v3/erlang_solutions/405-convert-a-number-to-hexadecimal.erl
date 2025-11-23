-spec to_hex(Num :: integer()) -> unicode:unicode_binary().
to_hex(Num) when Num < 0 ->
    to_hex(Num + 16#100000000);
to_hex(0) ->
    <<"0">>;
to_hex(Num) ->
    to_hex(Num, []).

to_hex(0, Acc) ->
    list_to_binary(lists:reverse(Acc));
to_hex(Num, Acc) ->
    Rem = Num rem 16,
    HexChar = 
        case Rem of
            N when N < 10 -> $0 + N;
            _ -> $a + (Rem - 10)
        end,
    to_hex(Num div 16, [HexChar | Acc]).