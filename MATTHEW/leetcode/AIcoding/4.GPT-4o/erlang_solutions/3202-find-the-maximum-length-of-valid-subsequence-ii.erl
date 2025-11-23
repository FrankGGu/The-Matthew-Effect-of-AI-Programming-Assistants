-module(solution).
-export([max_valid_subsequence_length/1]).

max_valid_subsequence_length(List) ->
    max_length(List, 0, 0).

max_length([], Max, _) -> Max;
max_length([H|T], Max, Prev) ->
    NewMax = if
        H > Prev -> max(Max, 1 + max_length(T, 0, H));
        true -> max(Max, max_length(T, Max, Prev))
    end,
    max_length(T, NewMax, Prev).