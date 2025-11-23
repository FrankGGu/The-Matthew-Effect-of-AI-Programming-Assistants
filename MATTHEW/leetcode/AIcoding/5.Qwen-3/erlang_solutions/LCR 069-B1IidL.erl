-module(solution).
-export([peak_index/1]).

peak_index(A) ->
    peak_index(A, 1, length(A) - 1).

peak_index(A, Left, Right) ->
    Mid = (Left + Right) div 2,
    case lists:nth(Mid, A) < lists:nth(Mid + 1, A) of
        true -> peak_index(A, Mid + 1, Right);
        false -> peak_index(A, Left, Mid)
    end.