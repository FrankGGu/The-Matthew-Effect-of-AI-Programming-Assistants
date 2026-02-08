-module(solution).
-export([pass_the_pillow/2]).

pass_the_pillow(N, Time) ->
  T = Time rem (N * 2 - 2),
  if
    T < N ->
      T + 1;
    true ->
      N * 2 - 1 - T
  end.