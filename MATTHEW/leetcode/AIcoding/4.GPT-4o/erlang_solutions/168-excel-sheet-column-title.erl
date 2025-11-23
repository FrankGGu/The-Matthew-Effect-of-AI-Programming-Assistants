-spec convert_to_title(ColumnNumber :: integer()) -> unicode:unicode_binary().
convert_to_title(ColumnNumber) ->
    convert_to_title(ColumnNumber, []).

convert_to_title(0, Acc) -> lists:reverse(Acc);
convert_to_title(ColumnNumber, Acc) ->
    Remainder = (ColumnNumber - 1) rem 26,
    NewColumnNumber = (ColumnNumber - 1) div 26,
    convert_to_title(NewColumnNumber, [<<65 + Remainder:utf8>> | Acc]).
