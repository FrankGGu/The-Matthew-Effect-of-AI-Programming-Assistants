-module(detect_capital).
-export([detectCapitalUse/1]).

detectCapitalUse(Word) ->
  Len = length(Word),
  case Len of
    0 -> true;
    _ ->
      First = element(1, string:split(Word, "", all)),
      Rest = string:substr(Word, 2, Len - 1),
      case {is_upper(First), is_upper_rest(Rest), is_lower_rest(Rest)} of
        {true, true, _} -> true;
        {true, _, true} -> true;
        {false, _, true} -> true;
        _ -> false
      end
  end.

is_upper(S) ->
  lists:all(fun(C) -> C >= $A andalso C =< $Z end, S).

is_lower(S) ->
  lists:all(fun(C) -> C >= $a andalso C =< $z end, S).

is_upper_rest(S) ->
  case S of
    "" -> true;
    _ ->
      lists:all(fun(C) -> C >= $A andalso C =< $Z end, string:to_list(S))
  end.

is_lower_rest(S) ->
  case S of
    "" -> true;
    _ ->
      lists:all(fun(C) -> C >= $a andalso C =< $z end, string:to_list(S))
  end.