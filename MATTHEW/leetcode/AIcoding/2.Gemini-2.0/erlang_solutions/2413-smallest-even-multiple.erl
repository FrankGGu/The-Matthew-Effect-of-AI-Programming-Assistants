-module(smallest_even_multiple).
-export([smallest_even_multiple/1]).

smallest_even_multiple(N) ->
  if N rem 2 == 0 ->
    N;
  true ->
    N * 2
  end.