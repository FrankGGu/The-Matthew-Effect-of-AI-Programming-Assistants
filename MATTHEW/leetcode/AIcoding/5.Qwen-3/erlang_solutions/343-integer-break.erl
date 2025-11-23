-module(interior_break).
-export([integer_break/1]).

integer_break(N) ->
    integer_break(N, 0).

integer_break(2, Acc) ->
    Acc + 2;
integer_break(3, Acc) ->
    Acc + 3;
integer_break(N, Acc) ->
    integer_break(N - 3, Acc + 3).