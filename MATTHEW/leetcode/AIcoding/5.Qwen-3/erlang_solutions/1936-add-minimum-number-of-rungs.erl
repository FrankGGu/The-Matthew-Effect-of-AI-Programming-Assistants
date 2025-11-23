-module(add_minimum_number_of_rungs).
-export([add_rungs/1]).

add_rungs(Rungs) ->
    add_rungs(Rungs, 0, 0).

add_rungs([], _, Count) ->
    Count;
add_rungs([H | T], Prev, Count) ->
    Diff = H - Prev,
    if
        Diff > 2 ->
            add_rungs(T, H, Count + (Diff - 1) div 2);
        true ->
            add_rungs(T, H, Count)
    end.