-module(count_vowel_substrings).
-export([count_vowel_substrings/1]).

count_vowel_substrings(Word) ->
    count_vowel_substrings(string:to_list(Word), 0).

count_vowel_substrings(Word, Count) ->
    Len = length(Word),
    count_vowel_substrings(Word, 0, Len, Count).

count_vowel_substrings(_, I, Len, Count) when I >= Len ->
    Count;
count_vowel_substrings(Word, I, Len, Count) ->
    count_vowel_substrings(Word, I, I+1, Len, Count).

count_vowel_substrings(_, I, J, Len, Count) when J > Len ->
    Count;
count_vowel_substrings(Word, I, J, Len, Count) ->
    Sub = lists:sublist(Word, I+1, J-I),
    case is_vowel_substring(Sub) of
        true ->
            count_vowel_substrings(Word, I, J+1, Len, Count+1);
        false ->
            count_vowel_substrings(Word, I, J+1, Len, Count)
    end.

is_vowel_substring(Sub) ->
    case is_all_vowels(Sub) andalso is_all_vowels_present(Sub) of
        true ->
            true;
        false ->
            false
    end.

is_all_vowels([]) ->
    true;
is_all_vowels([H|T]) ->
    case is_vowel(H) of
        true ->
            is_all_vowels(T);
        false ->
            false
    end.

is_vowel(Char) ->
    lists:member(Char, "aeiou").

is_all_vowels_present(Sub) ->
    lists:all(fun(Vowel) -> lists:member(Vowel, Sub) end, "aeiou").