-module(solution).
-export([xorGame/1]).

xorGame(N) ->
    case N rem 2 of
        0 -> true;
        _ -> false
    end.