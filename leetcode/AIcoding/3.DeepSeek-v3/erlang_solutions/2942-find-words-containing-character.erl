-spec find_words_containing(Words :: [unicode:unicode_binary()], X :: char()) -> [integer()].
find_words_containing(Words, X) ->
    lists:filtermap(
        fun({Word, Index}) ->
            case binary:match(Word, <<X>>) of
                nomatch -> false;
                _ -> {true, Index}
            end
        end,
        lists:zip(Words, lists:seq(0, length(Words) - 1))
    ).