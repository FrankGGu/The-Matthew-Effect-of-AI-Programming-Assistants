-module(partition_string).
-export([partition_string/2]).

partition_string(S, K) ->
  partition_string(S, K, [], 0).

partition_string([], _K, Acc, _Current) ->
  length(Acc);
partition_string([H|T], K, Acc, Current) ->
  Value = char_to_int(H),
  case Current * 10 + Value =< K of
    true ->
      partition_string(T, K, Acc, Current * 10 + Value);
    false ->
      partition_string(T, K, [1|Acc], Value)
  end.

char_to_int(C) ->
  C - $0 + 0.