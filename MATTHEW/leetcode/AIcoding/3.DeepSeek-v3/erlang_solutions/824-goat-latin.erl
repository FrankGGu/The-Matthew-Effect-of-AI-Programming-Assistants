-spec to_goat_latin(S :: unicode:unicode_binary()) -> unicode:unicode_binary().
to_goat_latin(S) ->
    Words = binary:split(S, <<" ">>, [global]),
    Processed = lists:map(fun(Word) -> process_word(Word) end, Words),
    WithA = add_a_suffix(Processed, 1),
    binary:join(WithA, <<" ">>).

process_word(Word) ->
    case is_vowel(Word) of
        true ->
            <<Word/binary, "ma">>;
        false ->
            <<First:8, Rest/binary>> = Word,
            <<Rest/binary, First:8, "ma">>
    end.

is_vowel(<<C:8, _/binary>>) ->
    Vowels = "aeiouAEIOU",
    lists:member(C, Vowels).

add_a_suffix(Words, Index) ->
    lists:map(fun(Word) ->
        Suffix = binary:copy(<<"a">>, Index),
        <<Word/binary, Suffix/binary>>
    end, Words).