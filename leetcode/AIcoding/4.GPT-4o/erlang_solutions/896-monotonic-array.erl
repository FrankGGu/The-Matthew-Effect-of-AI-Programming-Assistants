-module(solution).
-export([is_monotonic/1]).

is_monotonic(A) ->
    is_increasing(A) orelse is_decreasing(A).

is_increasing([]) -> true;
is_increasing([_]) -> true;
is_increasing([H1, H2 | T]) -> 
    (H1 =< H2) andalso is_increasing([H2 | T]).

is_decreasing([]) -> true;
is_decreasing([_]) -> true;
is_decreasing([H1, H2 | T]) -> 
    (H1 >= H2) andalso is_decreasing([H2 | T]).