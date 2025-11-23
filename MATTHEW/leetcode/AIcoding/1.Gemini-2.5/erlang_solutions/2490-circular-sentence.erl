-module(solution).
-export([is_circular_sentence/1]).

is_circular_sentence(Sentence) ->
    Words = string:tokens(Sentence, " "),

    case Words of
        [Word] ->
            % Single word case: first character must be equal to its last character
            hd(Word) == lists:last(Word);
        [FirstWord | RestWords] ->
            % Multiple words case
            % Condition 2: The first character of the first word is equal to the last character of the last word.
            LastWord = lists:last(Words),
            Condition2 = (hd(FirstWord) == lists:last(LastWord)),

            % Condition 1: The first character of each word is equal to the last character of the previous word.
            Condition1 = check_adjacent_words(FirstWord, RestWords),

            Condition1 andalso Condition2
    end.

check_adjacent_words(_PrevWord, []) ->
    true; % All adjacent pairs checked successfully
check_adjacent_words(PrevWord, [CurrentWord | RestWords]) ->
    (lists:last(PrevWord) == hd(CurrentWord)) andalso
    check_adjacent_words(CurrentWord, RestWords).