-module(solution).
-export([min_rectangles_to_cover_points/2]).

min_rectangles_to_cover_points(Points, W) ->
    Sorted = lists:sort(Points),
    cover(Sorted, W, -1, 0).

cover([], _, _, Count) -> Count;
cover([X | Rest], W, Last, Count) when Last =:= -1 ->
    cover(Rest, W, X, Count + 1);
cover([X | Rest], W, Last, Count) when X - Last =< W ->
    cover(Rest, W, Last, Count);
cover([X | Rest], W, _, Count) ->
    cover(Rest, W, X, Count + 1).