-module(solution).
-export([firstBadVersion/1]).

firstBadVersion(N) ->
    binary_search(1, N).

binary_search(Low, High) when Low > High ->
    Low;
binary_search(Low, High) ->
    Mid = Low + (High - Low) div 2,
    case isBadVersion(Mid) of
        true ->
            binary_search(Low, Mid - 1);
        false ->
            binary_search(Mid + 1, High)
    end.