-module(solution).
-export([dest_city/1]).

dest_city(Pairs) ->
    Cities = lists:map(fun({From, _}) -> From end, Pairs),
    Destinations = lists:map(fun({_, To}) -> To end, Pairs),
    lists:filter(fun(City) -> not lists:member(City, Cities) end, Destinations).