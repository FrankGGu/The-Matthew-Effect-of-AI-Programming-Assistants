-module(solution).
-export([find_number_of_subsequences_with_equal_gcd/2]).

find_number_of_subsequences_with_equal_gcd(Nums, K) ->
    FilteredNums = lists:filter(fun(X) -> X rem K == 0 end, Nums),

    if FilteredNums == [] ->
        0;
    true ->
        B = lists:map(fun(X) -> X div K end, FilteredNums),

        MaxVal = lists:foldl(fun(X, Acc) -> max(X, Acc) end, 0, B),

        FreqMap = lists:foldl(fun(X, M) -> maps:update_with(X, fun(V) -> V + 1 end, 1, M) end, #{}, B),

        GetFreq = fun(Val, Map) -> maps:get(Val, Map, 0) end,

        CountMultiplesMap = calculate_count_multiples(MaxVal, FreqMap, GetFreq),

        DpMap = calculate_dp_map(MaxVal, CountMultiplesMap),

        maps:get(1, DpMap, 0)
    end.

calculate_count_multiples(MaxVal, FreqMap, GetFreq) ->
    lists:foldl(fun(G, AccMap) ->
        CurrentCount = lists:foldl(fun(M, CurrentAcc) ->
            CurrentAcc + GetFreq(M, FreqMap)
        end, 0, lists:seq(G, MaxVal, G)),
        maps:put(G, CurrentCount, AccMap)
    end, #{}, lists:seq(1, MaxVal)).

calculate_dp_map(MaxVal, CountMultiplesMap) ->
    lists:foldl(fun(G, AccMap) ->
        NumElementsMultipleOfG = maps:get(G, CountMultiplesMap, 0),

        FG = if NumElementsMultipleOfG > 0 -> (1 bsl NumElementsMultipleOfG) - 1; true -> 0 end,

        CurrentDpG = lists:foldl(fun(M, CurrentAcc) ->
            CurrentAcc - maps:get(M, AccMap, 0)
        end, FG, lists:seq(2*G, MaxVal, G)),

        maps:put(G, CurrentDpG, AccMap)
    end, #{}, lists:reverse(lists:seq(1, MaxVal))).