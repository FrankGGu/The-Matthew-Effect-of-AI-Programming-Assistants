-module(solution).
-export([max_adjacent_difference/1]).

max_adjacent_difference(List) ->
    case List of
        [] -> 0;
        [_] -> 0;
        [H | T] ->
            max_diff_helper(T, H, H, 0)
    end.

max_diff_helper([], FirstElement, PrevElement, CurrentMaxDiff) ->
    max(CurrentMaxDiff, abs(PrevElement - FirstElement));
max_diff_helper([H | T], FirstElement, PrevElement, CurrentMaxDiff) ->
    Diff = abs(H - PrevElement),
    NewMaxDiff = max(CurrentMaxDiff, Diff),
    max_diff_helper(T, FirstElement, H, NewMaxDiff).