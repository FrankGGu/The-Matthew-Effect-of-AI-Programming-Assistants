-module(minimize_max_adjacent_element_diff).
-export([max_diff/1]).

max_diff(List) ->
    N = length(List),
    Sorted = lists:sort(List),
    min_diff(Sorted, 0, N - 1, 0).

min_diff(_, _, _, Acc) when Acc >= 2 -> Acc;
min_diff(Sorted, Left, Right, Acc) ->
    Mid = (Left + Right) div 2,
    if
        Mid > 0 andalso lists:nth(Mid, Sorted) - lists:nth(Mid - 1, Sorted) < 2 ->
            min_diff(Sorted, Left, Mid - 1, Acc + 1);
        Mid < length(Sorted) - 1 andalso lists:nth(Mid + 1, Sorted) - lists:nth(Mid, Sorted) < 2 ->
            min_diff(Sorted, Mid + 1, Right, Acc + 1);
        true ->
            min_diff(Sorted, Left, Mid - 1, Acc),
            min_diff(Sorted, Mid + 1, Right, Acc)
    end.