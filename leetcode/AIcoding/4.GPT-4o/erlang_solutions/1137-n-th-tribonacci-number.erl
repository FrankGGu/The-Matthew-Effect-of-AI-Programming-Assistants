-module(solution).
-export([tribonacci/1]).

tribonacci(N) when N == 0 -> 0;
tribonacci(N) when N == 1; N == 2 -> 1;
tribonacci(N) -> tribonacci(N-1) + tribonacci(N-2) + tribonacci(N-3).