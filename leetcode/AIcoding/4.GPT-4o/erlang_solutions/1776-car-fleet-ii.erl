-module(solution).
-export([carFleet/2]).

carFleet(Target, Position) ->
    N = length(Position),
    Sorted = lists:sort(Position),
    Distances = lists:map(fun(P) -> Target - P end, Sorted),
    Times = lists:map(fun(D) -> D end, Distances),
    MaxTimes = lists:foldl(fun(X, Acc) -> 
        case Acc of 
            [] -> [X]; 
            [H | T] -> [max(X, H) | T] 
        end 
    end, [], Times),
    length(MaxTimes).