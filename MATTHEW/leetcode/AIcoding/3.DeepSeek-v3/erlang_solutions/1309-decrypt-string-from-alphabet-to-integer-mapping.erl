-spec freq_alphabets(S :: unicode:unicode_binary()) -> unicode:unicode_binary().
freq_alphabets(S) ->
    freq_alphabets(S, []).

freq_alphabets(<<>>, Acc) ->
    unicode:characters_to_binary(lists:reverse(Acc));
freq_alphabets(<<C1, C2, $#, Rest/binary>>, Acc) when C1 >= $1, C1 =< $2, C2 >= $0, C2 =< $9 ->
    Num = (C1 - $0) * 10 + (C2 - $0),
    Char = $a + Num - 1,
    freq_alphabets(Rest, [Char | Acc]);
freq_alphabets(<<C, Rest/binary>>, Acc) when C >= $1, C =< $9 ->
    Char = $a + (C - $1),
    freq_alphabets(Rest, [Char | Acc]).