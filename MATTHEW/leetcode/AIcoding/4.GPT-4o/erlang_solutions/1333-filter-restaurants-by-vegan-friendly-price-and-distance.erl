-module(solution).
-export([filter_restaurants/4]).

filter_restaurants(Restaurants, VeganFriendly, MaxPrice, MaxDistance) ->
    lists:filter(fun({_, _, Vegan, Price, Distance}) ->
        (Vegan =:= VeganFriendly orelse VeganFriendly =:= 0) andalso
        Price =< MaxPrice andalso
        Distance =< MaxDistance
    end, Restaurants).