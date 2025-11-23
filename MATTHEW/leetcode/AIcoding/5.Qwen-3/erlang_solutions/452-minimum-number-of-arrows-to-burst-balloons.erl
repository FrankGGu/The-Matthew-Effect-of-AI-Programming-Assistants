-module(burst_balloons).
-export([find_min_arrow_shots/1]).

find_min_arrow_shots(Balloons) ->
    Sorted = lists:sort(Balloons),
    find_min(Sorted, 0, 0).

find_min([], _, Count) ->
    Count;
find_min([[X1, Y1] | Rest], LastY, Count) ->
    if
        Y1 < LastY ->
            find_min(Rest, LastY, Count);
        true ->
            find_min(Rest, Y1, Count + 1)
    end.