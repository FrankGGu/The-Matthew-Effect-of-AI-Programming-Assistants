-module(longest_new_string).
-export([solve/3]).

solve(A, B, C) ->
  case A > B of
    true -> 2 * B + 2 * C + 1;
    false -> 2 * A + 2 * C + 1
  end.