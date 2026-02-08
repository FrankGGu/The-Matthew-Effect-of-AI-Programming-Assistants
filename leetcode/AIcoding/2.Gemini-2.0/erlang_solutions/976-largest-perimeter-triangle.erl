-module(largest_perimeter_triangle).
-export([largest_perimeter/1]).

largest_perimeter(Nums) ->
    Sorted = lists:sort(Nums, fun(A, B) -> A > B end),
    largest_perimeter_helper(Sorted).

largest_perimeter_helper([A, B, C | Rest]) ->
    if A < B + C then
        A + B + C
    else
        largest_perimeter_helper([B, C | Rest])
    end;
largest_perimeter_helper(_) ->
    0.