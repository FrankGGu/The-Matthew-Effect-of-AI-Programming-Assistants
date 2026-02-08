-spec is_prefix_of_word(Sentence :: unicode:unicode_binary(), SearchWord :: unicode:unicode_binary()) -> integer().
is_prefix_of_word(Sentence, SearchWord) ->
    Words = binary:split(Sentence, <<" ">>, [global]),
    SearchWordLen = byte_size(SearchWord),
    find_prefix(Words, SearchWord, SearchWordLen, 1).

find_prefix([], _, _, _) -> -1;
find_prefix([Word | Rest], SearchWord, SearchWordLen, Index) ->
    case byte_size(Word) >= SearchWordLen andalso binary:part(Word, 0, SearchWordLen) =:= SearchWord of
        true -> Index;
        false -> find_prefix(Rest, SearchWord, SearchWordLen, Index + 1)
    end.