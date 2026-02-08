-module(solution).
-export([min_cost_to_equalize_array/2]).

min_cost_to_equalize_array(Nums, Cost) ->
    Max = lists:max(Nums),
    Min = lists:min(Nums),
    Total = lists:sum(Nums),
    Len = length(Nums),
    if
        Max == Min -> 0;
        true ->
            PossibleTargets = lists:seq(Max, Max + 1),
            lists:min(lists:map(fun(Target) -> calculate_cost(Nums, Cost, Target) end, PossibleTargets))
    end.

calculate_cost(Nums, [C1, C2], Target) ->
    Inc = 0,
    Dec = 0,
    lists:foldl(fun(Num, {I, D}) ->
        if
            Num < Target -> {I + (Target - Num), D};
            true -> {I, D + (Num - Target)}
        end
    end, {Inc, Dec}, Nums),
    {Increment, Decrement} = lists:foldl(fun(Num, {I, D}) ->
        if
            Num < Target -> {I + (Target - Num), D};
            true -> {I, D + (Num - Target)}
        end
    end, {0, 0}, Nums),
    min(Increment * C1, Decrement * C2) + abs(Increment - Decrement) * min(C1, C2).