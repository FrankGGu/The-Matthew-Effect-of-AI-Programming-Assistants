-spec di_string_match(S :: unicode:unicode_binary()) -> [integer()].
di_string_match(S) ->
    N = byte_size(S),
    Low = 0,
    High = N,
    di_string_match(S, Low, High, []).

di_string_match(<<>>, Low, _High, Acc) ->
    lists:reverse([Low | Acc]);
di_string_match(<<"I", Rest/binary>>, Low, High, Acc) ->
    di_string_match(Rest, Low + 1, High, [Low | Acc]);
di_string_match(<<"D", Rest/binary>>, Low, High, Acc) ->
    di_string_match(Rest, Low, High - 1, [High | Acc]).