-module(maximum_number_of_occurrences_of_a_substring).
-export([maxNumberOfOccurrences/2]).

maxNumberOfOccurrences(Paragraph, SearchWord) ->
    maxNumberOfOccurrences(Paragraph, SearchWord, 0, 0).

maxNumberOfOccurrences([], _, _, Count) ->
    Count;
maxNumberOfOccurrences([C | Rest], SearchWord, Index, Count) ->
    case isMatch(Rest, SearchWord, 0) of
        true ->
            maxNumberOfOccurrences(Rest, SearchWord, Index + 1, Count + 1);
        false ->
            maxNumberOfOccurrences(Rest, SearchWord, Index + 1, Count)
    end.

isMatch([], _, _) ->
    false;
isMatch([C | Rest], [C | WordRest], Index) ->
    if
        Index == length(WordRest) ->
            true;
        true ->
            isMatch(Rest, WordRest, Index + 1)
    end;
isMatch([_ | Rest], SearchWord, Index) ->
    isMatch(Rest, SearchWord, Index).