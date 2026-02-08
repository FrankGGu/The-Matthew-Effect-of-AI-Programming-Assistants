-module(solution).
-export([longest_subarray/1]).

longest_subarray(List) ->
    Max = lists:max(List),
    Lengths = lists:foldl(fun (X, {Count, MaxCount}) ->
        if
            X == Max -> {Count + 1, MaxCount};
            true -> {0, max(Count, MaxCount)}
        end
    end, {0, 0}, List),
    max(Lengths#{}).