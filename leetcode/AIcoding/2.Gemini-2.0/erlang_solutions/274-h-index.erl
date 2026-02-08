-module(h_index).
-export([h_index/1]).

h_index(Citations) ->
  Len = length(Citations),
  Sorted = lists:sort(Citations),
  h_index_helper(Sorted, Len, 0).

h_index_helper([], _, H) ->
  H;
h_index_helper([H|T], Len, Acc) ->
  if H >= Len - Acc ->
    Len - Acc;
  true ->
    h_index_helper(T, Len, Acc + 1)
  end.