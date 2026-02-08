-module(solution).
-export([search_range/1]).

search_range([]) -> [-1, -1];
search_range([H|T]) when H /= 0 ->
    search_range(T);
search_range(List) ->
    Left = find_left(List, 0),
    Right = find_right(List, 0),
    [Left, Right].

find_left([], _) -> -1;
find_left([H|T], Target) when H == Target ->
    0;
find_left([H|T], Target) ->
    case find_left(T, Target) of
        -1 -> -1;
        Index -> Index + 1
    end.

find_right([], _) -> -1;
find_right([H|T], Target) when H == Target ->
    0;
find_right([H|T], Target) ->
    case find_right(T, Target) of
        -1 -> -1;
        Index -> Index + 1
    end.