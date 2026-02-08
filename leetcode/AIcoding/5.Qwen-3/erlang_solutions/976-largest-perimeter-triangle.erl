-module(largest_perimeter_triangle).
-export([largest_perimeter/1]).

largest_perimeter(Nums) ->
    Sorted = lists:sort(Nums),
    largest_perimeter(Sorted, 0).

largest_perimeter([], _) ->
    0;
largest_perimeter([A,B,C|T], _) when A + B > C ->
    A + B + C;
largest_perimeter([_|T], _) ->
    largest_perimeter(T, 0).