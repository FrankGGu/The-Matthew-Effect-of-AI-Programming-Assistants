-module(solution).
-export([find_winning_player/2]).

find_winning_player(X, Y) ->
    MinXY = min(X, Y),
    case MinXY rem 2 of
        1 -> "Alice";
        0 -> "Bob"
    end.