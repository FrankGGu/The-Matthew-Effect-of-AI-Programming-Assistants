-module(minimum_additions).
-export([min_insertions/1]).

min_insertions(S) ->
  min_insertions(S, 0, 0).

min_insertions([], Prev, Acc) ->
  Acc;
min_insertions([$a | Rest], Prev, Acc) ->
  min_insertions(Rest, $a, Acc);
min_insertions([$b | Rest], $a, Acc) ->
  min_insertions(Rest, $b, Acc);
min_insertions([$b | Rest], _, Acc) ->
  min_insertions(Rest, $b, Acc + 1);
min_insertions([$c | Rest], $b, Acc) ->
  min_insertions(Rest, $c, Acc);
min_insertions([$c | Rest], _, Acc) ->
  min_insertions(Rest, $c, Acc + 2).