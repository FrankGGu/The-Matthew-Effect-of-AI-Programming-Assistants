-module(solution).
-export([square_is_white/1]).

square_is_white(S) ->
    [C, R] = string:to_list(S),
    (C - $a + R - $1) rem 2 == 1.