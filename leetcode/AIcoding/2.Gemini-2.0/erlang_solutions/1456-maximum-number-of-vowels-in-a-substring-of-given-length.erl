-module(maximum_vowels).
-export([max_vowels/2]).

max_vowels(S, K) ->
  max_vowels(S, K, 0, 0, 0).

max_vowels(_S, _K, _Start, _End, MaxVowels) when _End < 0 ->
  MaxVowels;

max_vowels(S, K, Start, End, MaxVowels) ->
  Len = length(S),
  if End >= Len ->
    MaxVowels
  else
    NewVowels = count_vowels(S, Start, End),
    if End - Start + 1 < K ->
      max_vowels(S, K, Start, End + 1, MaxVowels)
    else
      NewMaxVowels = max(MaxVowels, NewVowels),
      max_vowels(S, K, Start + 1, End + 1, NewMaxVowels)
    end
  end.

count_vowels(S, Start, End) ->
  count_vowels(S, Start, End, 0).

count_vowels(S, Start, End, Count) when Start > End ->
  Count;
count_vowels(S, Start, End, Count) ->
  Char = element(Start + 1, S),
  NewCount =
    case Char of
      $a -> Count + 1;
      $e -> Count + 1;
      $i -> Count + 1;
      $o -> Count + 1;
      $u -> Count + 1;
      _ -> Count
    end,
  count_vowels(S, Start + 1, End, NewCount).

max(A, B) ->
  if A > B ->
    A
  else
    B
  end.