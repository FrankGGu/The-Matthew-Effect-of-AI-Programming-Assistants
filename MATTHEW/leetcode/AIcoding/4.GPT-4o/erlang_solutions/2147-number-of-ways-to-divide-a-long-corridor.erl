-module(solution).
-export([countWays/1]).

countWays(Corridor) ->
    Length = length(Corridor),
    case Length rem 2 of
        1 -> 0;
        0 -> 
            Seats = lists:filter(fun(X) -> X =:= 1 end, Corridor),
            SeatsCount = length(Seats),
            if
                SeatsCount == 0 -> 1;
                SeatsCount rem 2 == 1 -> 0;
                true -> 
                    Mod = 1000000007,
                    Factorial = lists:foldl(fun(X, Acc) -> (Acc * X) rem Mod end, 1, lists:seq(1, SeatsCount div 2)),
                    Factorial
            end
    end.