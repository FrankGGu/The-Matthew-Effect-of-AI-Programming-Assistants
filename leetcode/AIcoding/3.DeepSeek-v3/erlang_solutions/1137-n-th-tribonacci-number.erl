-spec tribonacci(N :: integer()) -> integer().
tribonacci(0) -> 0;
tribonacci(1) -> 1;
tribonacci(2) -> 1;
tribonacci(N) when N > 2 ->
    tribonacci(N, 0, 1, 1).

tribonacci(3, A, B, C) -> A + B + C;
tribonacci(N, A, B, C) ->
    tribonacci(N - 1, B, C, A + B + C).