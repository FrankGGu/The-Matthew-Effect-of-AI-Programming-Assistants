-spec truncate_sentence(S :: unicode:unicode_binary(), K :: integer()) -> unicode:unicode_binary().
truncate_sentence(S, K) ->
    Words = binary:split(S, <<" ">>, [global]),
    Truncated = lists:sublist(Words, K),
    binary:join(Truncated, <<" ">>).