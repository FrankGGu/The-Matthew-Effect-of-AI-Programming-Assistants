-module(count_distinct_numbers).
-export([distinct_integers/1]).

distinct_integers(N) ->
  if N > 1 ->
    N - 1;
  true ->
    1
  end.