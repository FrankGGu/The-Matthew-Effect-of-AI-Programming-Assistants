-spec word_break(S :: unicode:unicode_binary(), WordDict :: [unicode:unicode_binary()]) -> boolean().
word_break(S, WordDict) ->
    word_break(S, WordDict, #{}) =:= true.

word_break(<<>>, _, _) -> true;
word_break(_, [], _) -> false;
word_break(S, WordDict, Memo) when maps:find(S, Memo) =:= none -> false;
word_break(S, WordDict, Memo) -> 
    lists:foldl(
        fun(Word, Acc) -> 
            case lists:prefix(Word, S) of
                true -> word_break(tl(S), WordDict, Memo);
                false -> Acc
            end
        end, 
        false,
        WordDict
    ).
