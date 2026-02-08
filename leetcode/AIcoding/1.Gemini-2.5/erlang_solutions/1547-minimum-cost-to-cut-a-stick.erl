-module(solution).
-export([minCost/2]).

minCost(N, Cuts) ->
    P = lists:sort([0, N | Cuts]),
    {ResultCost, _FinalMemo} = dp(0, length(P) - 1, P, #{}),
    ResultCost.

dp(I, J, P, Memo) ->
    if J - I =< 1 ->
        {0, Memo};
    true ->
        case maps:find({I, J}, Memo) of
            {ok, Cost} ->
                {Cost, Memo};
            error ->
                CurrentSegmentLength = lists:nth(J + 1, P) - lists:nth(I + 1, P),

                {MinSubProblemCost, NewMemoAfterSubCalls} = 
                    find_min_sub_problem_cost(I, J, P, Memo),

                TotalCost = CurrentSegmentLength + MinSubProblemCost,

                FinalMemo = maps:put({I, J}, TotalCost, NewMemoAfterSubCalls),
                {TotalCost, FinalMemo}
        end
    end.

find_min_sub_problem_cost(I, J, P, CurrentMemo) ->
    K0 = I + 1,
    {CostLeft0, Memo1} = dp(I, K0, P, CurrentMemo),
    {CostRight0, Memo2} = dp(K0, J, P, Memo1),
    InitialMinCost = CostLeft0 + CostRight0,

    find_min_sub_problem_cost_loop(I, J, P, Memo2, K0 + 1, InitialMinCost).

find_min_sub_problem_cost_loop(_I, J, _P, CurrentMemo, K, AccMinCost) when K >= J ->
    {AccMinCost, CurrentMemo};
find_min_sub_problem_cost_loop(I, J, P, CurrentMemo, K, AccMinCost) ->
    {CostLeft, Memo1} = dp(I, K, P, CurrentMemo),
    {CostRight, Memo2} = dp(K, J, P, Memo1),

    CurrentCombinedCost = CostLeft + CostRight,

    NewAccMinCost = min(AccMinCost, CurrentCombinedCost),

    find_min_sub_problem_cost_loop(I, J, P, Memo2, K + 1, NewAccMinCost).