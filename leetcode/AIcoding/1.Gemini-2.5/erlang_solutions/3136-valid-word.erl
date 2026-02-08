-module(solution).
-export([is_valid_word/1]).

is_valid_word(Word) ->
    Chars = unicode:characters_to_list(Word),
    Len = length(Chars),

    if Len < 3 ->
        false;
    true ->
        check_chars(Chars, false, false)
    end.

check_chars([], HasVowel, HasConsonant) ->
    HasVowel and HasConsonant;
check_chars([H|T], HasVowel, HasConsonant) ->
    case H of
        C when (C >= $a and C <= $z) or (C >= $A and C <= $Z) -> % It's a letter
            case is_vowel(C) of
                true ->
                    check_chars(T, true, HasConsonant);
                false -> % It's a consonant
                    check_chars(T, HasVowel, true)
            end;
        C when C >= $0 and C <= $9 -> % It's a digit
            check_chars(T, HasVowel, HasConsonant);
        _ -> % Invalid character
            false
    end.

is_vowel(C) when C >= $A and C <= $Z -> is_vowel(C + 32); % Convert to lowercase
is_vowel($a) -> true;
is_vowel($e) -> true;
is_vowel($i) -> true;
is_vowel($o) -> true;
is_vowel($u) -> true;
is_vowel(_) -> false.