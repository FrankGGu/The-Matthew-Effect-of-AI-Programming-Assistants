-module(k_closest_points_to_origin).
-export([k_closest/2]).

k_closest(Points, K) ->
    Distances = [ {X*X + Y*Y, [X,Y]} || [X,Y] <- Points ],
    SortedDistances = lists:sort(Distances),
    K_ClosestTuples = lists:sublist(SortedDistances, K),
    [ Point || {_, Point} <- K_ClosestTuples ].