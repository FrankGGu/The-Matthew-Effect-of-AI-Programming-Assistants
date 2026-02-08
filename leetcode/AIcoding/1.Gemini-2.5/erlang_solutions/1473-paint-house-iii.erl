-module(solution).
-export([min_cost/5]).

min_cost(Houses, Cost, M, N, Target) ->
    MemoTable = ets:new(memo_table, [set, public, named_table]),

    Result = solve(0, 0, 0, Houses, Cost, M, N, Target, MemoTable),

    ets:delete(MemoTable),

    case Result of
        infinity -> -1;
        _ -> Result
    end.

solve(HouseIdx, Neighborhoods, LastColor, Houses, Cost, M, N, Target, MemoTable) ->
    Key = {HouseIdx, Neighborhoods, LastColor},
    case ets:lookup(MemoTable, Key) of
        [{_, Value}] -> Value;
        [] ->
            ComputedResult =
                if
                    Neighborhoods > Target ->
                        infinity;
                    HouseIdx == M ->
                        if
                            Neighborhoods == Target -> 0;
                            true -> infinity
                        end;
                    true ->
                        CurrentHouseColor = lists:nth(HouseIdx + 1, Houses),
                        if
                            CurrentHouseColor /= 0 ->
                                NewNeighborhoods =
                                    if
                                        LastColor == 0 -> 1;
                                        CurrentHouseColor == LastColor -> Neighborhoods;
                                        true -> Neighborhoods + 1
                                    end,
                                solve(HouseIdx + 1, NewNeighborhoods, CurrentHouseColor, Houses, Cost, M, N, Target, MemoTable);
                            true ->
                                calculate_min_cost_for_unpainted(HouseIdx, Neighborhoods, LastColor, Houses, Cost, M, N, Target, MemoTable)
                        end
                end,
            ets:insert(MemoTable, {Key, ComputedResult}),
            ComputedResult
    end.

calculate_min_cost_for_unpainted(HouseIdx, Neighborhoods, LastColor, Houses, Cost, M, N, Target, MemoTable) ->
    MinCost = infinity,
    lists:foldl(fun(Color, AccMinCost) ->
        NewNeighborhoods =
            if
                LastColor == 0 -> 1;
                Color == LastColor -> Neighborhoods;
                true -> Neighborhoods + 1
            end,

        PaintCost = lists:nth(Color, lists:nth(HouseIdx + 1, Cost)),

        SubProblemCost = solve(HouseIdx + 1, NewNeighborhoods, Color, Houses, Cost, M, N, Target, MemoTable),

        CombinedCost = 
            if 
                SubProblemCost == infinity -> infinity;
                true -> PaintCost + SubProblemCost
            end,

        min(AccMinCost, CombinedCost)
    end, MinCost, lists:seq(1, N)).