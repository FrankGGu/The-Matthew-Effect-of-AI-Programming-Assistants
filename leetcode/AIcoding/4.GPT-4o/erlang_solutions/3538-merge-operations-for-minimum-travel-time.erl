-module(solution).
-export([minimum_travel_time/1]).

minimum_travel_time(Operations) ->
    lists:foldl(fun({X, Y}, Acc) ->
        lists:foldl(fun({Z1, Z2}, Acc1) ->
            min(Acc1, X + Z1 + Y + Z2)
        end, Acc, Acc)
    end, infinity, Operations).