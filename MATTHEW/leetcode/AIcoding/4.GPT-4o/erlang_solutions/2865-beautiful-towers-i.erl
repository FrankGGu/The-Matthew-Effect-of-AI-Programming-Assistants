-module(solution).
-export([beautifulTowers/1]).

beautifulTowers(N) ->
    case N rem 2 of
        0 -> 0;
        _ -> 1
    end.