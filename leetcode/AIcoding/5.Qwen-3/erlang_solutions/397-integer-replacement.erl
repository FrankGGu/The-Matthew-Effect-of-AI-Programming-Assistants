-module(int_integer_replacement).
-export([integer_replacement/1]).

integer_replacement(N) ->
    integer_replacement(N, 0).

integer_replacement(1, Count) ->
    Count;
integer_replacement(N, Count) when N rem 2 == 0 ->
    integer_replacement(N div 2, Count + 1);
integer_replacement(N, Count) ->
    case (N + 1) rem 4 of
        0 ->
            integer_replacement(N + 1, Count + 1);
        _ ->
            integer_replacement(N - 1, Count + 1)
    end.