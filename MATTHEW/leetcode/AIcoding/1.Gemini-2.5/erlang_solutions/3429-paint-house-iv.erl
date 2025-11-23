-module(solution).
-export([minCost/4]).

minCost(HousesList, CostList, M, N, Target) ->
    Infinity = 1_000_000_000 + 7,

    Houses = list_to_tuple(HousesList),
    CostTuples = [list_to_tuple(Row) || Row <- CostList],
    Cost = list_to_tuple(CostTuples),

    {Result, _FinalMemo} = dp(0, 0, 0, Houses, Cost, M, N, Target, #{}, Infinity),

    case Result of
        Infinity -> -1;
        _ -> Result
    end.

dp(Index, PrevColor, K, Houses, Cost, M, N, Target, Memo, Infinity) ->
    case maps:find({Index, PrevColor, K}, Memo) of
        {ok, Val} -> {Val, Memo};
        _ ->
            if
                K > Target ->
                    {Infinity, Memo};
                Index == M ->
                    if
                        K == Target -> {0, Memo};
                        true -> {Infinity, Memo}
                    end;
                true ->
                    HouseColor = element(Index + 1, Houses),

                    {MinCost, UpdatedMemo} =
                        if
                            HouseColor =/= 0 ->
                                CurrentColor = HouseColor,
                                NewK = calculate_new_k(PrevColor, CurrentColor, K),
                                dp(Index + 1, CurrentColor, NewK, Houses, Cost, M, N, Target, Memo, Infinity);
                            true ->
                                calculate_min_cost_for_uncolored(1, N, Index, PrevColor, K, Houses, Cost, M, Target, Memo, Infinity, Infinity)
                        end,

                    NewMemo = maps:put({Index, PrevColor, K}, MinCost, UpdatedMemo),
                    {MinCost, NewMemo}
            end
    end.

calculate_new_k(0, _CurrentColor, _K) -> 1;
calculate_new_k(PrevColor, CurrentColor, K) ->
    if
        PrevColor == CurrentColor -> K;
        true -> K + 1
    end.

calculate_min_cost_for_uncolored(Color, N, Index, PrevColor, K, Houses, Cost, M, Target, Memo, Infinity, AccMinCost) ->
    if
        Color > N -> {AccMinCost, Memo};
        true ->
            CurrentColor = Color,
            NewK = calculate_new_k(PrevColor, CurrentColor, K),

            HouseCostRow = element(Index + 1, Cost),
            PaintCost = element(CurrentColor, HouseCostRow),

            {RemainingCost, UpdatedMemoFromDP} = dp(Index + 1, CurrentColor, NewK, Houses, Cost, M, N, Target, Memo, Infinity),

            TotalCost =
                if
                    RemainingCost == Infinity -> Infinity;
                    true -> PaintCost + RemainingCost
                end,

            NextAccMinCost = min(AccMinCost, TotalCost),
            calculate_min_cost_for_uncolored(Color + 1, N, Index, PrevColor, K, Houses, Cost, M, Target, UpdatedMemoFromDP, Infinity, NextAccMinCost)
    end.