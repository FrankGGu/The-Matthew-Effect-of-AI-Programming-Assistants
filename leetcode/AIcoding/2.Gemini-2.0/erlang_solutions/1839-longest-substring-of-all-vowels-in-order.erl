-module(longest_vowel_substring).
-export([longestVowelSubstring/1]).

longestVowelSubstring(Word) ->
  longestVowelSubstring(Word, 0, 0, 0, 0, 0, []).

longestVowelSubstring([], MaxLen, A, E, I, O, U) ->
  MaxLen;
longestVowelSubstring([H|T], MaxLen, A, E, I, O, U) ->
  case H of
    $a ->
      longestVowelSubstring(T, MaxLen, A + 1, 0, 0, 0, 0);
    $e ->
      case A > 0 of
        true ->
          longestVowelSubstring(T, MaxLen, 0, E + 1, 0, 0, 0);
        false ->
          longestVowelSubstring(T, MaxLen, 0, 0, 0, 0, 0)
      end;
    $i ->
      case E > 0 of
        true ->
          longestVowelSubstring(T, MaxLen, 0, 0, I + 1, 0, 0);
        false ->
          longestVowelSubstring(T, MaxLen, 0, 0, 0, 0, 0)
      end;
    $o ->
      case I > 0 of
        true ->
          longestVowelSubstring(T, MaxLen, 0, 0, 0, O + 1, 0);
        false ->
          longestVowelSubstring(T, MaxLen, 0, 0, 0, 0, 0)
      end;
    $u ->
      case O > 0 of
        true ->
          Len = A + E + I + O + U + 1,
          NewMaxLen = max(MaxLen, Len),
          longestVowelSubstring(T, NewMaxLen, 0, 0, 0, 0, U + 1);
        false ->
          longestVowelSubstring(T, MaxLen, 0, 0, 0, 0, 0)
      end;
    _ ->
      longestVowelSubstring(T, MaxLen, 0, 0, 0, 0, 0)
  end.