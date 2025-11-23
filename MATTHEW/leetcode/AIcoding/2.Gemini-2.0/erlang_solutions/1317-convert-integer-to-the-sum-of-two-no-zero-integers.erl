-module(solution).
-export([solve/1]).

solve(N) ->
  find_no_zero_integers(N, 1).

find_no_zero_integers(N, A) ->
  B = N - A,
  case is_no_zero(A) andalso is_no_zero(B) of
    true -> {A, B};
    false -> find_no_zero_integers(N, A + 1)
  end.

is_no_zero(N) ->
  is_no_zero_helper(N, true).

is_no_zero_helper(0, Acc) ->
  Acc;
is_no_zero_helper(N, Acc) ->
  case N rem 10 of
    0 -> false;
    _ -> is_no_zero_helper(N div 10, Acc)
  end.