-module(minimum_time_to_remove_cars).
-export([min_removal_time/1]).

min_removal_time(S) ->
    min_removal_time(S, 0, 0, length(S)).

min_removal_time([], Cost, _, _) ->
    Cost;
min_removal_time([H|T], Cost, LeftCost, N) ->
    I = N - length(T) - 1,
    CaseCost = case H of
        $0 -> 0;
        $1 -> 1
    end,
    TakeCaseCost = Cost + CaseCost,
    RemoveLeftCost = min(I + 1, LeftCost + I + 1),
    RemoveRightCost = min(N - I, Cost + N - I),
    RemoveBothCost = min(RemoveLeftCost + N - I, RemoveRightCost + I + 1),
    min_removal_time(T, min(TakeCaseCost, RemoveBothCost), RemoveLeftCost, N).