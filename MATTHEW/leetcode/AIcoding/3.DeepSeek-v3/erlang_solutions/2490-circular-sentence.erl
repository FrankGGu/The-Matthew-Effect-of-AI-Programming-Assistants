-spec is_circular_sentence(Sentence :: unicode:unicode_binary()) -> boolean().
is_circular_sentence(Sentence) ->
    Words = binary:split(Sentence, <<" ">>, [global]),
    case Words of
        [] -> true;
        [First | _] = WordList ->
            LastWord = lists:last(WordList),
            FirstChar = binary:first(First),
            LastChar = binary:last(LastWord),
            check_circular(WordList, FirstChar, LastChar)
    end.

check_circular([], _, _) -> true;
check_circular([Word], FirstChar, LastChar) -> 
    binary:first(Word) == LastChar andalso binary:last(Word) == FirstChar;
check_circular([Word, Next | Rest], FirstChar, LastChar) ->
    binary:last(Word) == binary:first(Next) andalso check_circular([Next | Rest], FirstChar, LastChar).