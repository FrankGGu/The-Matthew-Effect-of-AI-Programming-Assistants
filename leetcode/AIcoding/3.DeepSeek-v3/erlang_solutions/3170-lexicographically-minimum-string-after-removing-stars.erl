-spec minimum_string(S :: unicode:unicode_binary()) -> unicode:unicode_binary().
minimum_string(S) ->
    minimum_string(S, []).

minimum_string(<<>>, Stack) ->
    list_to_binary(lists:reverse(Stack));
minimum_string(<<$*, Rest/binary>>, [_ | Stack]) ->
    minimum_string(Rest, Stack);
minimum_string(<<Char, Rest/binary>>, Stack) ->
    minimum_string(Rest, [Char | Stack]).