-module(smallest_set_bits).
-export([solve/1]).

solve(N) ->
  (1 bsl (N)) - 1.