-spec word_break(S :: unicode:unicode_binary(), WordDict :: [unicode:unicode_binary()]) -> [unicode:unicode_binary()].
word_break(S, WordDict) ->
    word_break(S, WordDict, #{}).

word_break(<<>>, _, _) -> [<<>>];
word_break(S, WordDict, Memo) when is_list(WordDict) ->
    case maps:get(S, Memo, undefined) of
        undefined ->
            Results = lists:flatmap(fun(Word) ->
                        if 
                            lists:prefix(Word, S) -> 
                                Tail = tl(Word),
                                case word_break(tl(S), WordDict, Memo) of
                                    [] -> [Word];
                                    Sentences -> [Word ++ <<" ">> ++ Sentence || Sentence <- Sentences]
                                end;
                            true -> []
                        end
                    end, WordDict),
            MemoedResults = maps:put(S, Results, Memo),
            Results;
        Results -> Results
    end.
