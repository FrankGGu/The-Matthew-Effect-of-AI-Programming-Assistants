-module(solution).
-export([minimum_right_shifts/1]).

minimum_right_shifts(Array) ->
    Sorted = lists:sort(Array),
    case right_shifts(Array, Sorted, 0) of
        {ok, Shifts} -> Shifts;
        error -> -1
    end.

right_shifts([], [], Shifts) -> {ok, Shifts};
right_shifts(Array, Sorted, Shifts) ->
    if
        Array =:= Sorted -> {ok, Shifts};
        true -> 
            NewArray = lists:drop(1, Array) ++ [hd(Array)],
            right_shifts(NewArray, Sorted, Shifts + 1)
    end.