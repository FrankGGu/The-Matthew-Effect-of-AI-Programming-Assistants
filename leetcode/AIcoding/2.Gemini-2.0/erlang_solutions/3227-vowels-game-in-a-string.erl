-module(vowels_game).
-export([get_vowels_score/1]).

get_vowels_score(S) ->
  get_vowels_score(S, 0).

get_vowels_score([], Acc) ->
  Acc;
get_vowels_score([H|T], Acc) ->
  Score = score(H, length([H|T])),
  get_vowels_score(T, Acc + Score).

score(Char, Length) ->
  case is_vowel(Char) of
    true -> Length;
    false -> 0
  end.

is_vowel(Char) ->
  case Char of
    $a -> true;
    $e -> true;
    $i -> true;
    $o -> true;
    $u -> true;
    _ -> false
  end.