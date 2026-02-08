-module(h_index_ii).
-export([h_index/1]).

h_index(Citations) ->
  N = length(Citations),
  h_index_helper(Citations, 0, N - 1, N).

h_index_helper(Citations, Low, High, N) ->
  if Low > High ->
    N - Low;
  true ->
    Mid = Low + (High - Low) div 2,
    if Citations[Mid + 1] >= N - Mid ->
      h_index_helper(Citations, Low, Mid - 1, N);
    true ->
      h_index_helper(Citations, Mid + 1, High, N)
    end
  end.