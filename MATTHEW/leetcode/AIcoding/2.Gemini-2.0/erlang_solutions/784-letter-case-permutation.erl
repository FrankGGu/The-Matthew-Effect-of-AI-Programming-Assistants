-module(letter_case_permutation).
-export([letter_case_permutation/1]).

letter_case_permutation(S) ->
  Chars = string:to_list(S),
  permute(Chars, []).

permute([], Acc) ->
  [lists:reverse(Acc)];
permute([H|T], Acc) ->
  case is_alpha(H) of
    true ->
      Lower = to_lower(H),
      Upper = to_upper(H),
      permute(T, [Lower|Acc]) ++ permute(T, [Upper|Acc]);
    false ->
      permute(T, [H|Acc])
  end.

is_alpha(Char) ->
  (Char >= $a andalso Char <= $z) orelse (Char >= $A andalso Char <= $Z).

to_lower(Char) ->
  case Char >= $A andalso Char <= $Z of
    true -> Char + 32;
    false -> Char
  end.

to_upper(Char) ->
  case Char >= $a andalso Char <= $z of
    true -> Char - 32;
    false -> Char
  end.