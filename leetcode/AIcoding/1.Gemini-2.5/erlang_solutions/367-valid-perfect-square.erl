-module(solution).
-export([isPerfectSquare/1]).

isPerfectSquare(Num) ->
    binary_search(1, Num, Num).

binary_search(Low, High, Target) ->
    if
        Low > High ->
            false;
        true ->
            Mid = Low + (High - Low) div 2,
            MidSq = Mid * Mid,
            if
                MidSq == Target ->
                    true;
                MidSq < Target ->
                    binary_search(Mid + 1, High, Target);
                true -> % MidSq > Target
                    binary_search(Low, Mid - 1, Target)
            end
    end.