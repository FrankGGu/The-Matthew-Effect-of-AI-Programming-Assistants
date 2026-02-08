-module(solution).
-export([smallest_even_multiple/1]).

-spec smallest_even_multiple(N :: integer()) -> integer().
smallest_even_multiple(N) when N rem 2 == 0 ->
    N;
smallest_even_multiple(N) ->
    2 * N.