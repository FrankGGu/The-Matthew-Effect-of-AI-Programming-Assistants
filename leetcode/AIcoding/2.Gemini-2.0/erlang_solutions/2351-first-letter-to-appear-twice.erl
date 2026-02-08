-module(first_letter_twice).
-export([first_letter_twice/1]).

first_letter_twice(S) ->
  first_letter_twice(S, []).

first_letter_twice([], _) ->
  undefined;
first_letter_twice([H|T], Seen) ->
  case lists:member(H, Seen) of
    true ->
      H;
    false ->
      first_letter_twice(T, [H|Seen])
  end.