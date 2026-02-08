-spec reformat_number(Number :: unicode:unicode_binary()) -> unicode:unicode_binary().
reformat_number(Number) ->
    Cleaned = binary:replace(Number, [<<" ">>, <<"-">>], <<>>, [global]),
    reformat(Cleaned, <<>>).

reformat(<<A, B, C, Rest/binary>>, Acc) when byte_size(Rest) > 1 ->
    NewAcc = <<Acc/binary, A, B, C, "-">>,
    reformat(Rest, NewAcc);
reformat(<<A, B, C>>, Acc) ->
    <<Acc/binary, A, B, C>>;
reformat(<<A, B>>, Acc) ->
    <<Acc/binary, A, B>>;
reformat(<<A, B, C, D>>, Acc) ->
    <<Acc/binary, A, B, "-", C, D>>.