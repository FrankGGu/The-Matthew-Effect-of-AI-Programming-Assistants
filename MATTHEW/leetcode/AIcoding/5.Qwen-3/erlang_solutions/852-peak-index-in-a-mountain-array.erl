-module(peak_index_in_a_mountain_array).
-export([peak_index/1]).

peak_index(A) ->
    peak_index(A, 0, length(A) - 1).

peak_index(A, Left, Right) when Left < Right ->
    Mid = (Left + Right) div 2,
    case element(Mid + 1, A) > element(Mid, A) of
        true -> peak_index(A, Mid + 1, Right);
        false -> peak_index(A, Left, Mid)
    end;
peak_index(A, Left, _) ->
    Left.