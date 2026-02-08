-module(maximize_partitions_after_operations).
-export([max_partitions_after_operations/1]).

max_partitions_after_operations(S) ->
  max_partitions_after_operations(S, 0).

max_partitions_after_operations([], Acc) ->
  Acc;
max_partitions_after_operations(S, Acc) ->
  max_partitions_after_operations(tl(S), Acc + check_partition(hd(S))).

check_partition(Row) ->
  Unique = lists:usort(Row),
  case length(Unique) =< 2 of
    true -> 1;
    false -> 0
  end.