-module(unique_occurrences).
-export([solve/1]).

solve(Arr) ->
  Counts = lists:sort([count(X, Arr) || X <- lists:usort(Arr)]),
  lists:all(fun(X) -> lists:filter(fun(Y) -> Y == X end, Counts) == [X] end, Counts).

count(X, List) ->
  count(X, List, 0).

count(_, [], Acc) ->
  Acc;
count(X, [X|Rest], Acc) ->
  count(X, Rest, Acc + 1);
count(X, [_|Rest], Acc) ->
  count(X, Rest, Acc).