-module(solution).
-export([filter_restaurants/2]).

filter_restaurants(Restaurants, Filters) ->
    [R || R <- Restaurants, is_match(R, Filters)].

is_match([Id, Name, Vegan, Price, Distance], {VeganFilter, PriceLimit, DistanceLimit}) ->
    (VeganFilter == 0 orelse Vegan == 1) andalso
    (Price <= PriceLimit) andalso
    (Distance <= DistanceLimit).