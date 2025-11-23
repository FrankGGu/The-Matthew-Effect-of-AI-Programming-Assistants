-module(solution).
-export([count_vowel_substrings/3]).

count_vowel_substrings(S, K, N) ->
    Count = count_vowels(S, K, N, 0, 0, 0),
    Count.

count_vowels(S, K, N, Start, VowelCount, ConsonantCount) ->
    case Start of
        Length when Length >= N -> 
            if VowelCount > 0 andalso ConsonantCount >= K -> 
                1 + count_vowels(S, K, N, Start + 1, VowelCount, ConsonantCount - is_consonant(element(Start + 1, S))) 
            else 
                count_vowels(S, K, N, Start + 1, VowelCount, ConsonantCount - is_consonant(element(Start + 1, S))) 
            end;
        0 -> 
            count_vowels(S, K, N, 1, is_vowel(element(0, S)), is_consonant(element(0, S)));
        Length -> 
            count_vowels(S, K, N, Length + 1, VowelCount + is_vowel(element(Length, S)), ConsonantCount + is_consonant(element(Length, S)))
    end.

is_vowel(Char) -> 
    case Char of
        $a; $e; $i; $o; $u; $A; $E; $I; $O; $U -> 1;
        _ -> 0
    end.

is_consonant(Char) -> 
    case Char of
        $a; $e; $i; $o; $u; $A; $E; $I; $O; $U -> 0;
        _ when Char >= $a, Char =< $z; Char >= $A, Char =< $Z -> 1;
        _ -> 0
    end.