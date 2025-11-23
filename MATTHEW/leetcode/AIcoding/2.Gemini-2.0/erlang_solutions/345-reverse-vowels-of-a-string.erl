-module(reverse_vowels).
-export([reverse_vowels/1]).

reverse_vowels(String) ->
  StringList = string:to_list(String),
  Vowels = [C || C <- StringList, is_vowel(C)],
  RevVowels = lists:reverse(Vowels),
  reverse_vowels_helper(StringList, RevVowels, []).

reverse_vowels_helper([], [], Acc) ->
  lists:reverse(Acc);
reverse_vowels_helper([], RevVowels, Acc) ->
  lists:reverse(Acc);
reverse_vowels_helper([H|T], [], Acc) ->
  lists:reverse(Acc) ++ [H] ++ T;
reverse_vowels_helper([H|T], [V|RT], Acc) ->
  case is_vowel(H) of
    true ->
      reverse_vowels_helper(T, RT, [V|Acc]);
    false ->
      reverse_vowels_helper(T, [V|RT], [H|Acc])
  end.

is_vowel(Char) ->
  lists:member(Char, "aeiouAEIOU").