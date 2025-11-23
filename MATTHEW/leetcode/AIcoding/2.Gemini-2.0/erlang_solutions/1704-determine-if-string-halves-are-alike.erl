-module(halves_alike).
-export([halvesAreAlike/1]).

halvesAreAlike(S) ->
  Len = length(S),
  HalfLen = Len div 2,
  Half1 = string:substr(S, 1, HalfLen),
  Half2 = string:substr(S, HalfLen + 1, HalfLen),
  Vowels = "aeiouAEIOU",
  countVowels(Half1, Vowels) == countVowels(Half2, Vowels).

countVowels(String, Vowels) ->
  countVowelsHelper(String, Vowels, 0).

countVowelsHelper([], _, Count) ->
  Count;
countVowelsHelper([H|T], Vowels, Count) ->
  case string:chr(Vowels, H) of
    0 ->
      countVowelsHelper(T, Vowels, Count);
    _ ->
      countVowelsHelper(T, Vowels, Count + 1)
  end.