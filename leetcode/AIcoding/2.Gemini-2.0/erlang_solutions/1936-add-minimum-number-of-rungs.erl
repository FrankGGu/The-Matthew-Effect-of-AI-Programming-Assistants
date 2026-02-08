-module(solution).
-export([add_minimum_number_of_rungs/2]).

add_minimum_number_of_rungs(Rungs, Dist) ->
    add_minimum_number_of_rungs(Rungs, Dist, 0, 0).

add_minimum_number_of_rungs([], _Dist, Count, _Prev) ->
    Count;
add_minimum_number_of_rungs([H|T], Dist, Count, Prev) ->
    Diff = H - Prev;
    if
        Diff > Dist ->
            NewCount = Count + (Diff - 1) div Dist;
            add_minimum_number_of_rungs(T, Dist, NewCount, H);
        true ->
            add_minimum_number_of_rungs(T, Dist, Count, H)
    end.