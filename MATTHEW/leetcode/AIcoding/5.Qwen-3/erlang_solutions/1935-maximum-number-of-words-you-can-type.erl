-module(maximum_number_of_words_you_can_type).
-export([canBeTypedWords/2]).

canBeTypedWords(Keyboard, Words) ->
    Keys = lists:usort(Keyboard),
    WordsList = string:split(Words, " ", all),
    count_words(Keys, WordsList, 0).

count_words(_, [], Count) ->
    Count;
count_words(Keys, [Word | Rest], Count) ->
    case is_valid_word(Word, Keys) of
        true -> count_words(Keys, Rest, Count + 1);
        false -> count_words(Keys, Rest, Count)
    end.

is_valid_word([], _) ->
    true;
is_valid_word([Char | Rest], Keys) ->
    lists:member(Char, Keys) andalso is_valid_word(Rest, Keys).