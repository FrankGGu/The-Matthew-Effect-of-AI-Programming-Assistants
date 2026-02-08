-module(solution).
-export([fib/1]).

fib(N) -> fib_tail_recursive(N, 0, 1).

fib_tail_recursive(0, A, _) -> A;
fib_tail_recursive(N, A, B) when N > 0 -> fib_tail_recursive(N - 1, B, A + B).