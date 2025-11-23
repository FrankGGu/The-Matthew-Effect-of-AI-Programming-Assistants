-module(solution).
-export([minCostToEqualizeArray/3]).

minCostToEqualizeArray(Nums, Cost1, Cost2) ->
    N = length(Nums),
    MaxVal = lists:max(Nums),
    Sum = lists:sum(Nums),

    EffectiveCost2 = erlang:min(Cost2, 2 * Cost1),

    Low = MaxVal,
    High = MaxVal + 2 * N,

    ternary_search(Low, High, N, Sum, Cost1, EffectiveCost2).

ternary_search(Low, High, N, Sum, Cost1, EffectiveCost2) ->
    ternary_search_loop(Low, High, 100, N, Sum, Cost1, EffectiveCost2).

ternary_search_loop(Low, High, 0, N, Sum, Cost1, EffectiveCost2) ->
    calculate_cost(Low, N, Sum, Cost1, EffectiveCost2);
ternary_search_loop(Low, High, Iterations, N, Sum, Cost1, EffectiveCost2) when Low < High ->
    Mid1 = Low + (High - Low) div 3,
    Mid2 = High - (High - Low) div 3,

    CostMid1 = calculate_cost(Mid1, N, Sum, Cost1, EffectiveCost2),
    CostMid2 = calculate_cost(Mid2, N, Sum, Cost1, EffectiveCost2),

    if
        CostMid1 < CostMid2 ->
            ternary_search_loop(Low, Mid2 - 1, Iterations - 1, N, Sum, Cost1, EffectiveCost2);
        true ->
            ternary_search_loop(Mid1 + 1, High, Iterations - 1, N, Sum, Cost1, EffectiveCost2)
    end;
ternary_search_loop(Low, _High, _Iterations, N, Sum, Cost1, EffectiveCost2) ->
    calculate_cost(Low, N, Sum, Cost1, EffectiveCost2).

calculate_cost(Target, N, Sum, Cost1, EffectiveCost2) ->
    TotalInc = N * Target - Sum,

    if
        TotalInc < 0 ->
            (1 bsl 62); 
        true ->
            NumPairs = TotalInc div 2,
            RemainingInc = TotalInc rem 2,
            NumPairs * EffectiveCost2 + RemainingInc * Cost1
    end.