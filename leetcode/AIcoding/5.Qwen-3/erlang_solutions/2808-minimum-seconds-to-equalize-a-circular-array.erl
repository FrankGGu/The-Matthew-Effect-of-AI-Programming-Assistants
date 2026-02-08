-module(minimum_seconds_to_equalize_a_circular_array).
-export([minSeconds/1]).

minSeconds(Remove) ->
    minSeconds(Remove, 0, 0).

minSeconds([], _, _) ->
    0;
minSeconds([H | T], Max, Count) ->
    if
        H == 0 ->
            minSeconds(T, Max, 0);
        true ->
            NewCount = Count + 1,
            if
                NewCount > Max ->
                    minSeconds(T, NewCount, 0);
                true ->
                    minSeconds(T, Max, NewCount)
            end
    end.