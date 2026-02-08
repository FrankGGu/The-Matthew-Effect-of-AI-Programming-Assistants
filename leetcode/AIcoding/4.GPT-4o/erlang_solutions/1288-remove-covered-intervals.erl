-module(solution).
-export([remove_covered_intervals/1]).

remove_covered_intervals(Intervals) ->
    Sorted = lists:sort(fun({A1, B1}, {A2, B2}) -> 
        case A1 - A2 of
            0 -> B1 > B2;
            _ -> A1 < A2
        end
    end, Intervals),
    remove_covered(Sorted, 0, 0).

remove_covered([], _, Count) -> Count;
remove_covered([{A, B} | Rest], MaxEnd, Count) ->
    if
        B > MaxEnd ->
            remove_covered(Rest, B, Count + 1);
        true ->
            remove_covered(Rest, MaxEnd, Count)
    end.