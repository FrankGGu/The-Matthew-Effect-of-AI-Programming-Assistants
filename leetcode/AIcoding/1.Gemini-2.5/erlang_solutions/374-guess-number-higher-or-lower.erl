-module(solution).
-export([guessNumber/1]).

guessNumber(N) ->
    binary_search(1, N).

binary_search(Low, High) when Low =< High ->
    Mid = Low + (High - Low) div 2,
    case guess(Mid) of
        0 -> Mid;
        -1 -> binary_search(Low, Mid - 1);
        1 -> binary_search(Mid + 1, High)
    end.