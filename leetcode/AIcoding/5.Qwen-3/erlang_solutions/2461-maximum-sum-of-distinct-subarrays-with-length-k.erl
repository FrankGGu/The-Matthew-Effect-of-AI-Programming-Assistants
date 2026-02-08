-module(maximum_sum_of_distinct_subarrays_with_length_k).
-export([findMaxAverage/2]).

findMaxAverage(Nums, K) ->
    L = length(Nums),
    if
        K > L -> 0.0;
        true ->
            Map = maps:new(),
            Sum = lists:foldl(fun(I, Acc) -> Acc + lists:nth(I, Nums) end, 0, lists:seq(1, K)),
            MaxSum = Sum,
            CurrentSum = Sum,
            CurrentMap = populate_map(Nums, 1, K, Map),
            find_max(CurrentSum, MaxSum, CurrentMap, Nums, K, 2, L)
    end.

populate_map(_, _, K, Map) when K < 1 -> Map;
populate_map(Nums, Start, End, Map) ->
    Val = lists:nth(Start, Nums),
    NewMap = maps:update(Val, maps:get(Val, Map, 0) + 1, Map),
    populate_map(Nums, Start + 1, End, NewMap).

find_max(_, MaxSum, _, _, _, _, _) when K > length(Nums) -> MaxSum / K;
find_max(CurrentSum, MaxSum, CurrentMap, Nums, K, Start, L) ->
    NextVal = lists:nth(Start + K - 1, Nums),
    PrevVal = lists:nth(Start - 1, Nums),
    NewCurrentSum = CurrentSum - PrevVal + NextVal,
    NewCurrentMap = maps:put(PrevVal, maps:get(PrevVal, CurrentMap) - 1, CurrentMap),
    case maps:get(NextVal, NewCurrentMap, 0) of
        0 ->
            NewCurrentMap2 = maps:put(NextVal, 1, NewCurrentMap),
            NewMaxSum = max(MaxSum, NewCurrentSum),
            find_max(NewCurrentSum, NewMaxSum, NewCurrentMap2, Nums, K, Start + 1, L);
        _ ->
            NewCurrentMap2 = maps:put(NextVal, maps:get(NextVal, NewCurrentMap) + 1, NewCurrentMap),
            if
                maps:size(NewCurrentMap2) == K ->
                    NewMaxSum = max(MaxSum, NewCurrentSum),
                    find_max(NewCurrentSum, NewMaxSum, NewCurrentMap2, Nums, K, Start + 1, L);
                true ->
                    NewMaxSum = MaxSum,
                    find_max(NewCurrentSum, NewMaxSum, NewCurrentMap2, Nums, K, Start + 1, L)
            end
    end.