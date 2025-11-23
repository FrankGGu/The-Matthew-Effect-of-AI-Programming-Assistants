-module(special_characters_ii).
-export([count_special_characters/1]).

count_special_characters(S) ->
  count_special_characters(S, []).

count_special_characters([], Acc) ->
  length(Acc);
count_special_characters([H|T], Acc) ->
  case lists:member(H, Acc) of
    true ->
      count_special_characters(T, Acc);
    false ->
      case is_special(H) of
        true ->
          count_special_characters(T, [H|Acc]);
        false ->
          count_special_characters(T, Acc)
      end
  end.

is_special(Char) ->
  not (Char >= $a andalso Char =< $z) andalso
  not (Char >= $A andalso Char =< $Z) andalso
  not (Char >= $0 andalso Char =< $9).