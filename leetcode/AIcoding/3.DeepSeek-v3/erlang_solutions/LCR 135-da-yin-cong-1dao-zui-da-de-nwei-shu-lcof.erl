-spec count_and_say(N :: integer()) -> unicode:unicode_binary().
count_and_say(1) ->
    <<"1">>;
count_and_say(N) ->
    Prev = count_and_say(N - 1),
    count_and_say_helper(Prev, <<>>, 1, <<>>).

count_and_say_helper(<<>>, Acc, Count, Result) ->
    <<Result/binary, (integer_to_binary(Count))/binary, Acc/binary>>;
count_and_say_helper(<<H, Rest/binary>>, <<>>, _Count, Result) ->
    count_and_say_helper(Rest, <<H>>, 1, Result);
count_and_say_helper(<<H, Rest/binary>>, <<H, _/binary>> = Acc, Count, Result) ->
    count_and_say_helper(Rest, Acc, Count + 1, Result);
count_and_say_helper(<<H, Rest/binary>>, Acc, Count, Result) ->
    NewResult = <<Result/binary, (integer_to_binary(Count))/binary, Acc/binary>>,
    count_and_say_helper(Rest, <<H>>, 1, NewResult).