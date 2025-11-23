-module(vowel_strings).
-export([countVowelStrings/3]).

countVowelStrings(Words, Left, Right) ->
  count(Words, Left, Right, 0).

count([], _, _, Acc) ->
  Acc;
count(Words, Left, Right, Acc) ->
  count(Words, Left, Right, 0, 0, Acc).

count(_, Left, Right, Index, Count, Acc) when Index > Right ->
  Acc;
count(Words, Left, Right, Index, Count, Acc) ->
  Word = lists:nth(Index + 1, Words),
  case isVowelString(Word) of
    true ->
      count(Words, Left, Right, Index + 1, Count, Acc + 1);
    false ->
      count(Words, Left, Right, Index + 1, Count, Acc)
  end.

isVowelString(Word) ->
  case Word of
    "" ->
      false;
    _ ->
      First = hd(Word),
      Last = lists:last(Word),
      isVowel(First) and isVowel(Last)
  end.

isVowel(Char) ->
  lists:member(Char, "aeiou").