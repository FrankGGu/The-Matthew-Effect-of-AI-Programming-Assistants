-module(partition_list).
-export([partition/2]).

partition(Head, X) ->
  partition(Head, X, [], []).

partition([], _X, Less, Greater) ->
  lists:reverse(Less) ++ lists:reverse(Greater);
partition([H | T], X, Less, Greater) ->
  if
    H < X ->
      partition(T, X, [H | Less], Greater);
    true ->
      partition(T, X, Less, [H | Greater])
  end.