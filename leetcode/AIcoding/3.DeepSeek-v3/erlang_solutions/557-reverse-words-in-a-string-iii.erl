-spec reverse_words(S :: unicode:unicode_binary()) -> unicode:unicode_binary().
reverse_words(S) ->
    Words = binary:split(S, <<" ">>, [global]),
    ReversedWords = lists:map(fun(Word) -> reverse_word(Word) end, Words),
    binary:list_to_bin(lists:join(<<" ">>, ReversedWords)).

reverse_word(Word) ->
    list_to_binary(lists:reverse(binary_to_list(Word))).