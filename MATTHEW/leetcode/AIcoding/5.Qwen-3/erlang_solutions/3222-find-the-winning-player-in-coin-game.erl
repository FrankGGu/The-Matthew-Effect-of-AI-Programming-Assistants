-module(solution).
-export([find_winning_player/2]).

find_winning_player(N, X) ->
    case N rem 2 of
        0 -> if X == 1 -> 1; true -> 2 end;
        _ -> if X == 1 -> 2; true -> 1 end
    end.