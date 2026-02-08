-module(ant_on_boundary).
-export([ant_on_boundary/1]).

ant_on_boundary(N) when N > 0 ->
    case N rem 2 of
        0 -> 0;
        _ -> 1
    end.