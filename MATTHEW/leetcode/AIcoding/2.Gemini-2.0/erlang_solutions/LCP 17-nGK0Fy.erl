-module(solution).
-export([calculate/1]).

calculate(S) ->
  calculate(S, 1, 0).

calculate([], A, B) ->
  A * B.

calculate([H|T], A, B) ->
  case H of
    $A -> calculate(T, A * 2, B);
    $B -> calculate(T, A, B + A);
    _ -> calculate(T, A, B)
  end.