-module(shift_distance).
-export([shift_distance/2]).

shift_distance(S, T) ->
  shift_distance(string_to_list(S), string_to_list(T), 0).

shift_distance([], [], Acc) ->
  Acc;
shift_distance([H1|T1], [H2|T2], Acc) ->
  Diff = abs(H1 - H2),
  shift_distance(T1, T2, Acc + min(Diff, 26 - Diff)).