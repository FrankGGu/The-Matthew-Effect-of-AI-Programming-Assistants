-module(solution).
-export([remove_anagrams/1]).

remove_anagrams(WordList) ->
    remove_anagrams(WordList, []).

remove_anagrams([], Result) ->
    lists:reverse(Result);
remove_anagrams([Word | Rest], Result) ->
    case Result of
        [] ->
            remove_anagrams(Rest, [Word | Result]);
        [Last | _] ->
            case is_anagram(Word, Last) of
                true ->
                    remove_anagrams(Rest, Result);
                false ->
                    remove_anagrams(Rest, [Word | Result])
            end
    end.

is_anagram(A, B) ->
    lists:sort(A) == lists:sort(B).