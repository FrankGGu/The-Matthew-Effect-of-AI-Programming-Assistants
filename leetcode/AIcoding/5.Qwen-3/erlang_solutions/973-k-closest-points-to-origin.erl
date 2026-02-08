-module(k_closest_points).
-export([k_closest_points/2]).

k_closest_points(Points, K) ->
    Sorted = lists:sort(fun(A, B) -> distance(A) =< distance(B) end, Points),
    lists:sublist(Sorted, K).

distance({X, Y}) ->
    X * X + Y * Y.