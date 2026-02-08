-module(solution).
-export([shortest_distance/3]).

shortest_distance(Words, Target, Start) ->
    N = length(Words),

    case lists:nth(Start + 1, Words) of
        Target -> 0;
        _ ->
            RightDist = search_direction(Words, Target, Start, N, 0, fun(Idx, N_val) -> (Idx + 1) rem N_val end),
            LeftDist = search_direction(Words, Target, Start, N, 0, fun(Idx, N_val) -> (Idx - 1 + N_val) rem N_val end),
            min(RightDist, LeftDist)
    end.

search_direction(Words, Target, CurrentIdx, N, Steps, NextIdxFun) ->
    NewCurrentIdx = NextIdxFun(CurrentIdx, N),
    NewSteps = Steps + 1,

    case lists:nth(NewCurrentIdx + 1, Words) of
        Target -> NewSteps;
        _ -> search_direction(Words, Target, NewCurrentIdx, N, NewSteps, NextIdxFun)
    end.