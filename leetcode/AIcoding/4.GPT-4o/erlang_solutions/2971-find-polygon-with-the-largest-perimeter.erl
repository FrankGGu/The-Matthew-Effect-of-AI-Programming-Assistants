-module(solution).
-export([largest_perimeter/1]).

largest_perimeter(Sides) ->
    SortedSides = lists:sort(fun(A, B) -> A > B end, Sides),
    case largest_perimeter_helper(SortedSides) of
        {ok, Perimeter} -> Perimeter;
        _ -> 0
    end.

largest_perimeter_helper([A, B, C | _]) when A < B + C -> {ok, A + B + C};
largest_perimeter_helper([_ | T]) -> largest_perimeter_helper(T);
largest_perimeter_helper([]) -> {error, no_triangle}.