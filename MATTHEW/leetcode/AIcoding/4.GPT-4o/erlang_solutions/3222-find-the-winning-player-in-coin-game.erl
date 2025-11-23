-module(solution).
-export([find_winner/1]).

find_winner(Moves) ->
    Total = lists:sum(Moves),
    case Total rem 3 of
        0 -> "Player 3";
        1 -> "Player 1";
        2 -> "Player 2"
    end.