-module(solution).
-export([expectNumber/1]).

expectNumber(N) ->
    case N rem 2 of
        0 -> N div 2;
        _ -> (N div 2) + 1
    end.