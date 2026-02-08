-module(solution).
-export([find_all_concatenated_words_in_a_dict/1]).

-spec find_all_concatenated_words_in_a_dict([unicode:unicode_binary()]) -> [unicode:unicode_binary()].
find_all_concatenated_words_in_a_dict(Words) ->
    %% Convert the list of words to a set for fast lookups.
    WordSet = sets:from_list(Words),
    lists:filter(fun(Word) -> is_concatenated_word(Word, WordSet, 0) end, Words).

%% Helper function to check if a word can be formed by concatenating other words.
-spec is_concatenated_word(unicode:unicode_binary(), sets:set(unicode:unicode_binary()), integer()) -> boolean().
is_concatenated_word(_, _, 0) -> false; %% base case
is_concatenated_word(Word, WordSet, Start) ->
    case lists:prefix(Word, lists:drop(Start, Word)) of
        true -> 
            %% Check the remainder of the word after splitting
            case sets:member(Word, WordSet) of
                true -> true;
                false -> is_concatenated_word(Word, WordSet, Start + 1)
            end;
        false -> 
            is_concatenated_word(Word, WordSet, Start + 1)
    end.
