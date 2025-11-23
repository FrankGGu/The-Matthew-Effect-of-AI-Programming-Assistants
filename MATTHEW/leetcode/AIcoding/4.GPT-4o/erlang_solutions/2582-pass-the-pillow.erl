-module(solution).
-export([pass_the_pillow/3]).

pass_the_pillow(N, time, pos) ->
    if
        N =< 1 -> 1;
        true -> (pos + time) rem (2 * N - 2) + 1
    end.