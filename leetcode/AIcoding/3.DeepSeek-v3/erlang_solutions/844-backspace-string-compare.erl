-spec backspace_compare(S :: unicode:unicode_binary(), T :: unicode:unicode_binary()) -> boolean().
backspace_compare(S, T) ->
    process_string(S) =:= process_string(T).

process_string(S) ->
    process_string(S, []).

process_string(<<>>, Acc) ->
    lists:reverse(Acc);
process_string(<<$#, Rest/binary>>, []) ->
    process_string(Rest, []);
process_string(<<$#, Rest/binary>>, [_ | AccRest]) ->
    process_string(Rest, AccRest);
process_string(<<Char, Rest/binary>>, Acc) ->
    process_string(Rest, [Char | Acc]).