-module(solution).
-export([triangle_number/1]).

triangle_number(Sides) ->
    Sorted = lists:sort(Sides),
    count_valid_triangles(Sorted, 0).

count_valid_triangles([], Count) -> Count;
count_valid_triangles([_], Count) -> Count;
count_valid_triangles([_, _], Count) -> Count;
count_valid_triangles([A, B | Rest], Count) ->
    NewCount = count_for_two(A, B, Rest, Count),
    count_valid_triangles([B | Rest], NewCount).

count_for_two(A, B, Sides, Count) ->
    count_for_sum(A + B, Sides, Count).

count_for_sum(_, [], Count) -> Count;
count_for_sum(Sum, [C | Rest], Count) when C < Sum ->
    count_for_sum(Sum, Rest, Count + 1);
count_for_sum(_, _List, Count) -> Count.