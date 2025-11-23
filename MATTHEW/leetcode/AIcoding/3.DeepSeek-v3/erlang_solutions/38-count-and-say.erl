-spec count_and_say(N :: integer()) -> unicode:unicode_binary().
count_and_say(1) -> <<"1">>;
count_and_say(N) ->
    Prev = count_and_say(N - 1),
    count_and_say_helper(Prev, <<>>).

count_and_say_helper(<<>>, Acc) -> Acc;
count_and_say_helper(<<C, Rest/binary>>, Acc) ->
    {Count, NewRest} = count_chars(Rest, C, 1),
    NewAcc = <<Acc/binary, (integer_to_binary(Count))/binary, C>>,
    count_and_say_helper(NewRest, NewAcc).

count_chars(Bin, C, Count) when Bin =:= <<>> -> {Count, Bin};
count_chars(<<C, Rest/binary>>, C, Count) -> count_chars(Rest, C, Count + 1);
count_chars(Bin, _C, Count) -> {Count, Bin}.