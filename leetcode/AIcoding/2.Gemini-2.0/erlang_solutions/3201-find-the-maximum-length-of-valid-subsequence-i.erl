-module(solution).
-export([max_length/2]).

max_length(Nums, Banned) ->
  max_length(Nums, Banned, []).

max_length([], _, Acc) ->
  length(Acc);
max_length([H|T], Banned, Acc) ->
  case lists:member(H, Banned) of
    true ->
      max_length(T, Banned, Acc);
    false ->
      max_length(T, Banned, [H|Acc])
  end.