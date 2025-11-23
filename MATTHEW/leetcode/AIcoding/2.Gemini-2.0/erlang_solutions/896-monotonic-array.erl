-module(monotonic_array).
-export([is_monotonic/1]).

is_monotonic(A) ->
  case length(A) < 3 of
    true ->
      true;
    false ->
      Increasing = lists:all(fun({X, Y}) -> X =< Y end, lists:zip(A, tl(A))),
      Decreasing = lists:all(fun({X, Y}) -> X >= Y end, lists:zip(A, tl(A))),
      Increasing orelse Decreasing
  end.