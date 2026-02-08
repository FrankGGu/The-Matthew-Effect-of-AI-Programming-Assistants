-module(sort_vowels).
-export([sort_vowels/1]).

sort_vowels(S) ->
  Vowels = string:filter(S, fun is_vowel/1),
  SortedVowels = lists:sort(Vowels),
  {Result, _} = lists:foldl(
    fun(Char, {Acc, VowelIndex}) ->
      if is_vowel(Char) ->
        NewChar = lists:nth(VowelIndex + 1, SortedVowels),
        {Acc ++ [NewChar], VowelIndex + 1}
      else
        {Acc ++ [Char], VowelIndex}
      end
    end,
    {[], 0},
    string:to_list(S)
  ),
  list_to_binary(Result).

is_vowel($a) -> true;
is_vowel($e) -> true;
is_vowel($i) -> true;
is_vowel($o) -> true;
is_vowel($u) -> true;
is_vowel($A) -> true;
is_vowel($E) -> true;
is_vowel($I) -> true;
is_vowel($O) -> true;
is_vowel($U) -> true;
is_vowel(_) -> false.