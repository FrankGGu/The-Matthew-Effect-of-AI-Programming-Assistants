-module(solution).
-export([is_prefix_of_word/2]).

-spec is_prefix_of_word(Sentence :: unicode:unicode_binary(), SearchWord :: unicode:unicode_binary()) -> integer().
is_prefix_of_word(Sentence, SearchWord) ->
    Words = string:tokens(Sentence, <<" ">>),
    check_words(Words, SearchWord, 1).

check_words([], _SearchWord, _Index) ->
    -1;
check_words([Word | Rest], SearchWord, Index) ->
    if string:prefix(SearchWord, Word) ->
        Index;
    else
        check_words(Rest, SearchWord, Index + 1)
    end.