-module(optimal_partition).
-export([optimalPartition/1]).

optimalPartition(S) ->
  optimalPartition(S, [], 0).

optimalPartition([], _, Count) ->
  Count;
optimalPartition([H|T], Seen, Count) ->
  case lists:member(H, Seen) of
    true ->
      optimalPartition([H|T], [H], Count + 1);
    false ->
      optimalPartition(T, [H|Seen], Count)
  end.