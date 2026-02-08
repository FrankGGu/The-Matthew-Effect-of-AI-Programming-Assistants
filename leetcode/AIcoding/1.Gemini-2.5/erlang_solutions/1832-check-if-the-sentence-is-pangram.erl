-module(solution).
-export([checkIfPangram/1]).

checkIfPangram(Sentence) ->
    AlphabetSet = ordsets:from_list(lists:seq($a, $z)),
    process_sentence(Sentence, AlphabetSet).

process_sentence([], AlphabetSet) ->
    ordsets:is_empty(AlphabetSet);
process_sentence([Char|Rest], AlphabetSet) ->
    NewAlphabetSet = case Char of
                         C when C >= $A, C <= $Z -> ordsets:del(C + 32, AlphabetSet); % Convert to lowercase
                         C when C >= $a, C <= $z -> ordsets:del(C, AlphabetSet);
                         _ -> AlphabetSet % Ignore non-alphabetic characters
                     end,
    process_sentence(Rest, NewAlphabetSet).