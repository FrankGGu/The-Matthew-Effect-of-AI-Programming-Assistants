-module(reverse_only_letters).
-export([reverse_only_letters/1]).

reverse_only_letters(S) ->
  String = string:to_lower(S),
  Letters = lists:filter(fun is_letter/1), string:to_list(String)),
  ReversedLetters = lists:reverse(Letters),
  reconstruct(string:to_list(String), ReversedLetters, []).

is_letter(Char) ->
  (Char >= $a andalso Char <= $z) orelse (Char >= $A andalso Char <= $Z).

reconstruct([], _, Acc) ->
  lists:reverse(Acc);
reconstruct([H|T], [LH|LT], Acc) when is_letter(H) ->
  reconstruct(T, LT, [LH|Acc]);
reconstruct([H|T], L, Acc) ->
  reconstruct(T, L, [H|Acc]).