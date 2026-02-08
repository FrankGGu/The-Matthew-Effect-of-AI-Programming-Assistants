-module(solution).
-export([count_vowel_strings_in_range/3]).

count_vowel_strings_in_range(Words, Left, Right) ->
    Sublist = lists:sublist(Words, Left + 1, Right - Left + 1),
    Filtered = lists:filter(fun is_vowel_string/1, Sublist),
    length(Filtered).

is_vowel_string(String) when is_list(String), length(String) > 0 ->
    FirstChar = hd(String),
    LastChar = lists:last(String),
    is_vowel(FirstChar) andalso is_vowel(LastChar);
is_vowel_string(_) -> false.

is_vowel($a) -> true;
is_vowel($e) -> true;
is_vowel($i) -> true;
is_vowel($o) -> true;
is_vowel($u) -> true;
is_vowel(_) -> false.