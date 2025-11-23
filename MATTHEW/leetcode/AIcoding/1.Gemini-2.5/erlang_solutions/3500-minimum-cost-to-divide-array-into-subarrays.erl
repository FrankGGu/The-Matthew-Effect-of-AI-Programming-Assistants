-module(solution).
-export([min_cost_to_divide_array/2]).

-include_lib("kernel/include/array.hrl").

min_cost_to_divide_array(Nums, K) ->
    N = length(Nums),

    TrimCostMemo = precompute_trim_costs(Nums, N),

    Infinity = 1_000_000_000_000,
    Dp = array:new([{size, N+1}, {fixed, true}, {default, Infinity}]),
    Dp0 = array:set(0, 0, Dp),

    FinalDp = calculate_dp(1, N, K, Dp0, TrimCostMemo, Infinity),

    array:get(N, FinalDp).

precompute_trim_costs(Nums, N) ->
    TrimCostMemo = array:new([{size, N}, {fixed, true}]),
    precompute_trim_costs_loop_j(0, N, Nums, TrimCostMemo).

precompute_trim_costs_loop_j(J, N, Nums, TrimCostMemo) when J < N ->
    InnerArray = array:new([{size, N+1}, {fixed, true}]),
    {UpdatedInnerArray, _} = precompute_trim_costs_loop_i(J, J, N, Nums, InnerArray, 0, #{}),
    NewTrimCostMemo = array:set(J, UpdatedInnerArray, TrimCostMemo),
    precompute_trim_costs_loop_j(J + 1, N, Nums, NewTrimCostMemo).
precompute_trim_costs_loop_j(N, N, _Nums, TrimCostMemo) ->
    TrimCostMemo.

precompute_trim_costs_loop_i(J_Fixed, I, N, Nums, InnerArray, CurrentTrimCost, CountMap) when I < N ->
    Num = lists:nth(I + 1, Nums),
    Count = maps:get(Num, CountMap, 0),

    {NewCountMap, NewCurrentTrimCost} = 
        if
            Count == 0 ->
                {maps:put(Num, 1, CountMap), CurrentTrimCost};
            Count == 1 ->
                {maps:put(Num, 2, CountMap), CurrentTrimCost + 1};
            true ->
                {maps:put(Num, Count + 1, CountMap), CurrentTrimCost}
        end,

    UpdatedInnerArray = array:set(I + 1, NewCurrentTrimCost, InnerArray),
    precompute_trim_costs_loop_i(J_Fixed, I + 1, N, Nums, UpdatedInnerArray, NewCurrentTrimCost, NewCountMap).
precompute_trim_costs_loop_i(_J_Fixed, N, N, _Nums, InnerArray, CurrentTrimCost, _CountMap) ->
    {InnerArray, CurrentTrimCost}.

calculate_dp(I, N, K, Dp, TrimCostMemo, Infinity) when I =< N ->
    MinCostI = calculate_min_cost_for_i(I, 0, K, Dp, TrimCostMemo, Infinity, Infinity),
    NewDp = array:set(I, MinCostI, Dp),
    calculate_dp(I + 1, N, K, NewDp, TrimCostMemo, Infinity).
calculate_dp(I, N, _K, Dp, _TrimCostMemo, _Infinity) when I > N ->
    Dp.

calculate_min_cost_for_i(I, J, K, Dp, TrimCostMemo, CurrentMinCost, Infinity) when J < I ->
    PrevCost = array:get(J, Dp),

    TrimCostArrayForJ = array:get(J, TrimCostMemo),
    CurrentSubarrayTrimCost = array:get(I, TrimCostArrayForJ),

    Cost = PrevCost + CurrentSubarrayTrimCost + K,

    NewMinCost = min(CurrentMinCost, Cost),
    calculate_min_cost_for_i(I, J + 1, K, Dp, TrimCostMemo, NewMinCost, Infinity).
calculate_min_cost_for_i(_I, _J, _K, _Dp, _TrimCostMemo, CurrentMinCost, _Infinity) ->
    CurrentMinCost.