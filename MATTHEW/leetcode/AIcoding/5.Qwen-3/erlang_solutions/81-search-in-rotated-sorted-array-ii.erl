-module(solution).
-export([search/2]).

search(Rotated, Target) ->
    search(Rotated, Target, 0, length(Rotated) - 1).

search(_, _, L, R) when L > R ->
    false;
search(Rotated, Target, L, R) ->
    Mid = (L + R) div 2,
    case lists:nth(Mid + 1, Rotated) of
        Val when Val == Target ->
            true;
        Val when Val > Target ->
            case lists:nth(L + 1, Rotated) of
                Val2 when Val2 <= Target ->
                    search(Rotated, Target, L, Mid - 1);
                _ ->
                    search(Rotated, Target, Mid + 1, R)
            end;
        Val when Val < Target ->
            case lists:nth(L + 1, Rotated) of
                Val2 when Val2 <= Target ->
                    search(Rotated, Target, L, Mid - 1);
                _ ->
                    search(Rotated, Target, Mid + 1, R)
            end
    end.