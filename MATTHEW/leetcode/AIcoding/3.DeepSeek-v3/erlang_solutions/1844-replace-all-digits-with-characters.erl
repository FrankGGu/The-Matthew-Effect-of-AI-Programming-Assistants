-spec replace_digits(S :: unicode:unicode_binary()) -> unicode:unicode_binary().
replace_digits(S) ->
    replace_digits(S, 0, <<>>).

replace_digits(<<>>, _Index, Acc) ->
    Acc;
replace_digits(<<C, Rest/binary>>, Index, Acc) when Index rem 2 =:= 0 ->
    replace_digits(Rest, Index + 1, <<Acc/binary, C>>);
replace_digits(<<D, Rest/binary>>, Index, Acc) ->
    PrevChar = binary:at(Acc, byte_size(Acc) - 1),
    NewChar = PrevChar + (D - $0),
    replace_digits(Rest, Index + 1, <<Acc/binary, NewChar>>).