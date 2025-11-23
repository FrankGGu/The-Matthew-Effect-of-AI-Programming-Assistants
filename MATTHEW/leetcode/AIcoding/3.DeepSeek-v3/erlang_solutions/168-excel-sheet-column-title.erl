-spec convert_to_title(N :: integer()) -> unicode:unicode_binary().
convert_to_title(N) ->
    convert_to_title(N, []).

convert_to_title(0, Acc) ->
    unicode:characters_to_binary(lists:reverse(Acc));
convert_to_title(N, Acc) ->
    Remainder = (N - 1) rem 26,
    Char = $A + Remainder,
    convert_to_title((N - 1) div 26, [Char | Acc]).