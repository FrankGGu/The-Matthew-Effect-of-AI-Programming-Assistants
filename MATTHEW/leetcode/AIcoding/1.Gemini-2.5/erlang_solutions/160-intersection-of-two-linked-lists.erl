-module(solution).
-export([getIntersectionNode/2]).

getIntersectionNode(HeadA, HeadB) ->
    LenA = list_length(HeadA, 0),
    LenB = list_length(HeadB, 0),

    {LongerHead, ShorterHead, Diff} = 
        if 
            LenA >= LenB -> {HeadA, HeadB, LenA - LenB};
            true -> {HeadB, HeadA, LenB - LenA}
        end,

    LongerPtr = advance_ptr(LongerHead, Diff),

    find_intersection(LongerPtr, ShorterHead).

list_length(nil, Acc) -> Acc;
list_length(#{next := Next}, Acc) -> list_length(Next, Acc + 1).

advance_ptr(Ptr, 0) -> Ptr;
advance_ptr(nil, _) -> nil;
advance_ptr(#{next := Next}, N) -> advance_ptr(Next, N - 1).

find_intersection(nil, _) -> nil;
find_intersection(_, nil) -> nil;
find_intersection(PtrA, PtrA) -> PtrA;
find_intersection(#{next := NextA}, #{next := NextB}) -> find_intersection(NextA, NextB).