-module(consecutive_characters).
-export([max_power/1]).

max_power(S) ->
  max_power(S, 0, 0, $).

max_power([], CurrentMax, CurrentCount, _) ->
  max(CurrentMax, CurrentCount);
max_power([H|T], CurrentMax, CurrentCount, Prev) ->
  case H =:= Prev of
    true ->
      max_power(T, CurrentMax, CurrentCount + 1, H);
    false ->
      max_power(T, max(CurrentMax, CurrentCount), 1, H)
  end.

max(A, B) ->
  if
    A > B -> A;
    true -> B
  end.