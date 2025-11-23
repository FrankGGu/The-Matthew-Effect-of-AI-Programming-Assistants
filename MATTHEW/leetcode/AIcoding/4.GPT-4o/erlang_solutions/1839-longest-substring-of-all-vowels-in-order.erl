-module(solution).
-export([longest_vowel_substring/1]).

longest_vowel_substring(S) ->
    Vowels = "aeiou",
    longest_vowel_substring(S, Vowels, 0, 0, 0).

longest_vowel_substring([], _, MaxLen, CurrentLen, _) -> 
    MaxLen;
longest_vowel_substring([H | T], Vowels, MaxLen, CurrentLen, LastIdx) ->
    case lists:member(H, Vowels) of
        true ->
            NewIdx = lists:find(H, Vowels) + 1,
            case NewIdx - LastIdx of
                1 ->
                    longest_vowel_substring(T, Vowels, max(MaxLen, CurrentLen + 1), CurrentLen + 1, NewIdx);
                _ ->
                    longest_vowel_substring(T, Vowels, max(MaxLen, CurrentLen), 1, NewIdx)
            end;
        false ->
            longest_vowel_substring(T, Vowels, max(MaxLen, CurrentLen), 0, 0)
    end.