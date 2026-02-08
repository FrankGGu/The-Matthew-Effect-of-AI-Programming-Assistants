-module(solution).
-export([smallest_even_multiple/1]).

smallest_even_multiple(N) when N rem 2 == 0 -> N;
smallest_even_multiple(N) -> N * 2.