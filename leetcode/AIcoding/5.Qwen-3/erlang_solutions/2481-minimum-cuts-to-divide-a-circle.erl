-module(minimum_cuts).
-export([numberOfCuts/1]).

numberOfCuts(N) ->
    case N of
        0 -> 0;
        _ when N rem 2 == 0 -> N div 2;
        _ -> N
    end.