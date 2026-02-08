-module(solution).
-export([isMonotonic/1]).

isMonotonic(List) ->
    is_increasing(List) orelse is_decreasing(List).

is_increasing([]) -> true;
is_increasing([_]) -> true;
is_increasing([H1, H2 | T]) ->
    H1 =< H2 andalso is_increasing([H2 | T]).

is_decreasing([]) -> true;
is_decreasing([_]) -> true;
is_decreasing([H1, H2 | T]) ->
    H1 >= H2 andalso is_decreasing([H2 | T]).