-module(partition_labels).
-export([partition_labels/1]).

partition_labels(S) ->
  partition_labels(S, [], []).

partition_labels([], Acc, Result) ->
  lists:reverse(Result ++ [length(Acc)]);
partition_labels([H|T], Acc, Result) ->
  LastSeen = last_occurrence(H, [H|T], 0),
  partition_labels(T, Acc ++ [H], Result, LastSeen, 0).

partition_labels([], Acc, Result, _, MaxSeen) ->
  lists:reverse(Result ++ [length(Acc)]);
partition_labels([H|T], Acc, Result, LastSeen, MaxSeen) ->
  NewMaxSeen = max(MaxSeen, last_occurrence(H, Acc ++ [H|T], length(Acc))),
  case NewMaxSeen =< length(Acc) of
    true ->
      partition_labels(T, [], Result ++ [length(Acc)], 0, 0);
    false ->
      partition_labels(T, Acc ++ [H], Result, LastSeen, NewMaxSeen)
  end.

last_occurrence(Char, List, Index) ->
  last_occurrence(Char, List, Index, 0).

last_occurrence(Char, List, Index, MaxIndex) ->
  case lists:member(Char, List) of
    false ->
      MaxIndex;
    true ->
      NewList = lists:droplast(List),
      NewIndex = Index + length(List) - length(NewList) -1,
      last_occurrence(Char, NewList, Index, max(MaxIndex,NewIndex))
  end.