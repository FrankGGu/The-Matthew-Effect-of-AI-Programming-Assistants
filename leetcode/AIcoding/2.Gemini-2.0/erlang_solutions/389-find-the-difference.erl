-module(find_the_difference).
-export([find_the_difference/2]).

find_the_difference(S, T) ->
  find_diff(lists:sort(S), lists:sort(T)).

find_diff([], [H|_]) ->
  H;
find_diff([H1|T1], [H2|T2]) ->
  if
    H1 == H2 ->
      find_diff(T1, T2);
    true ->
      H2
  end.