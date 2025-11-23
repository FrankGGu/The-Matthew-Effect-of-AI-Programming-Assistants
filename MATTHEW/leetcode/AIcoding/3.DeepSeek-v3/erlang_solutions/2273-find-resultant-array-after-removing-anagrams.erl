-spec remove_anagrams(Words :: [unicode:unicode_binary()]) -> [unicode:unicode_binary()].
remove_anagrams(Words) ->
    remove_anagrams(Words, []).

remove_anagrams([], Result) ->
    lists:reverse(Result);
remove_anagrams([Word | Rest], []) ->
    remove_anagrams(Rest, [Word]);
remove_anagrams([Word | Rest], [Prev | _] = Result) ->
    case is_anagram(Word, Prev) of
        true -> remove_anagrams(Rest, Result);
        false -> remove_anagrams(Rest, [Word | Result])
    end.

is_anagram(Word1, Word2) ->
    lists:sort(binary_to_list(Word1)) =:= lists:sort(binary_to_list(Word2)).