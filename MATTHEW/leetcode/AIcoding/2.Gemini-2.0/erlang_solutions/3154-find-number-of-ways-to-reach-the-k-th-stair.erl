-module(solution).
-export([solve/1]).

solve(K) ->
  fib(K + 1).

fib(0) -> 0;
fib(1) -> 1;
fib(N) ->
  fib_helper(N, 1, 0).

fib_helper(0, _, Acc) -> Acc;
fib_helper(1, Acc, _) -> Acc;
fib_helper(N, A, B) ->
  fib_helper(N - 1, A + B, A).