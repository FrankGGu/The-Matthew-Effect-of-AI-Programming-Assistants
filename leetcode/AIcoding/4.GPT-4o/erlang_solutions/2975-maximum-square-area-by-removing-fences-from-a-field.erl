-module(max_square_area).
-export([max_square_area/1]).

max_square_area(Fences) ->
    MaxArea = lists:max(lists:map(fun({X, Y}) -> 
        min(X, Y) * min(X, Y) 
    end, Fences)),
    MaxArea.