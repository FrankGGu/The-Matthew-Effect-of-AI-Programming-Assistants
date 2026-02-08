-spec fib(N :: integer()) -> integer().
fib(N) ->
    fib(N, 0, 1).

fib(0, A, _B) -> A;
fib(1, _A, B) -> B;
fib(N, A, B) when N > 1 ->
    fib(N - 1, B, A + B).