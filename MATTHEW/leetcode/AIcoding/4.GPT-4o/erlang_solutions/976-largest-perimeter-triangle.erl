-module(solution).
-export([largest_perimeter/1]).

largest_perimeter(Sides) ->
    SortedSides = lists:sort(fun(X, Y) -> X > Y end, Sides),
    largest_perimeter_helper(SortedSides).

largest_perimeter_helper([]) ->
    0;
largest_perimeter_helper([A, B, C | Rest]) when A < B + C ->
    A + B + C;
largest_perimeter_helper([_ | Rest]) ->
    largest_perimeter_helper(Rest).