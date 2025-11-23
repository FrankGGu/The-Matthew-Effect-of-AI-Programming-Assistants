-spec max_number_of_words(Sentences :: [unicode:unicode_binary()]) -> integer().
max_number_of_words(Sentences) ->
    lists:max([length(string:lexemes(unicode:characters_to_list(Sentence), " ")) || Sentence <- Sentences]).