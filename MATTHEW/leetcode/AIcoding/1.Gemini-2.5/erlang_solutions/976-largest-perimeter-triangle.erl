-module(solution).
-export([largestPerimeter/1]).

largestPerimeter(A) ->
    SortedA = lists:sort(A),
    find_perimeter(lists:reverse(SortedA)).

find_perimeter([A, B, C | Rest]) ->
    if
        B + C > A ->
            A + B + C;
        true ->
            find_perimeter([B, C | Rest])
    end;
find_perimeter(_) ->
    0.