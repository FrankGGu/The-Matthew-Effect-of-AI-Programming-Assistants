-module(min_changes).
-export([min_changes/1]).

min_changes(S) ->
  min_changes(S, 0).

min_changes([], Count) ->
  Count;
min_changes([A, B | Rest], Count) ->
  case A =:= B of
    true ->
      min_changes(Rest, Count);
    false ->
      min_changes(Rest, Count + 1)
  end;
min_changes([_], Count) ->
  Count.