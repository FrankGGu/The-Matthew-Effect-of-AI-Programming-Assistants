-module(solution).
-export([max_marked_indices/1]).

max_marked_indices(Numbers) ->
    Sorted = lists:sort(Numbers),
    N = length(Sorted),
    Max = N div 2,
    Marked = lists:seq(0, Max - 1),
    find_max(Marked, Sorted, 0).

find_max([], _, Acc) ->
    Acc;
find_max([I | Rest], Sorted, Acc) ->
    J = I + (length(Sorted) - Max),
    if
        Sorted ! I >= Sorted ! J ->
            find_max(Rest, Sorted, Acc + 1);
        true ->
            find_max(Rest, Sorted, Acc)
    end.