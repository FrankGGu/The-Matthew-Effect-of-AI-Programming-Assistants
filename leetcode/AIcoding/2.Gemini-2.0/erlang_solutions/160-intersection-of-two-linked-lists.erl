-module(intersection_of_two_linked_lists).
-export([getIntersectionNode/2]).

getIntersectionNode(HeadA, HeadB) ->
    LenA = list_length(HeadA),
    LenB = list_length(HeadB),

    Diff = abs(LenA - LenB),

    {Longer, Shorter} = if LenA > LenB -> {HeadA, HeadB}; true -> {HeadB, HeadA} end,

    LongerTrimmed = skip(Longer, Diff),

    find_intersection(LongerTrimmed, Shorter).

list_length(List) ->
    list_length(List, 0).

list_length([], Acc) ->
    Acc;
list_length([_ | Tail], Acc) ->
    list_length(Tail, Acc + 1).

skip(List, N) ->
    skip(List, N, List).

skip([], _, Acc) ->
    Acc;
skip(List, 0, Acc) ->
    Acc;
skip([_ | Tail], N, _) ->
    skip(Tail, N - 1, _).

find_intersection(Longer, Shorter) ->
    find_intersection(Longer, Shorter, null).

find_intersection([], [], Acc) ->
    Acc;
find_intersection([], _, Acc) ->
    Acc;
find_intersection(_, [], Acc) ->
    Acc;
find_intersection([H | T], [H | T], _) ->
	H;
find_intersection([_H1 | T1], [_H2 | T2], _) ->
    find_intersection(T1, T2, null).
find_intersection([_H1 | T1], Shorter, Acc) ->
    find_intersection(T1, Shorter, Acc).
find_intersection(Longer, [_H2 | T2], Acc) ->
    find_intersection(Longer, T2, Acc).