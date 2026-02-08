-module(solution).
-export([count_substrings/3]).

count_substrings(S, K, _) ->
    Vowels = lists:usort("aeiou"),
    Length = string:length(S),
    count_substrings(S, Vowels, K, Length, 0, 0, 0).

count_substrings(_, _, _, 0, _, _, _) -> 0;
count_substrings(S, Vowels, K, Length, VowelCount, ConsonantCount, Start) ->
    case Start < Length of
        true ->
            case lists:member(string:substr(S, Start + 1, 1), Vowels) of
                true ->
                    count_substrings(S, Vowels, K, Length, VowelCount + 1, ConsonantCount, Start + 1);
                false ->
                    count_substrings(S, Vowels, K, Length, VowelCount, ConsonantCount + 1, Start + 1)
            end;
        false ->
            if
                VowelCount >= length(Vowels) andalso ConsonantCount >= K ->
                    1 + count_substrings(S, Vowels, K, Length, VowelCount, ConsonantCount, Start - 1);
                true ->
                    count_substrings(S, Vowels, K, Length, VowelCount, ConsonantCount, Start - 1)
            end
    end.