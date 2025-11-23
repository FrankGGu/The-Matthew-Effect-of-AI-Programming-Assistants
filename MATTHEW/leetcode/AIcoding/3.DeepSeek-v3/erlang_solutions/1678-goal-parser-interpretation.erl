-spec interpret(Command :: unicode:unicode_binary()) -> unicode:unicode_binary().
interpret(Command) ->
    interpret(Command, <<>>).

interpret(<<>>, Acc) ->
    Acc;
interpret(<<"G", Rest/binary>>, Acc) ->
    interpret(Rest, <<Acc/binary, "G">>);
interpret(<<"()", Rest/binary>>, Acc) ->
    interpret(Rest, <<Acc/binary, "o">>);
interpret(<<"(al)", Rest/binary>>, Acc) ->
    interpret(Rest, <<Acc/binary, "al">>).