-module(solution).
-export([min_time_to_brew_potions/2]).

min_time_to_brew_potions(Times, K) ->
    SortedTimes = lists:reverse(lists:sort(Times)),
    Low = lists:max(Times),
    High = lists:sum(Times),

    binary_search(Low, High, High, SortedTimes, K).

binary_search(L, H, Ans, SortedTimes, K) ->
    if
        L > H -> 
            Ans;
        true ->
            Mid = L + (H - L) div 2,
            if
                check(Mid, SortedTimes, K) ->
                    binary_search(L, Mid - 1, Mid, SortedTimes, K);
                true ->
                    binary_search(Mid + 1, H, Ans, SortedTimes, K)
            end
    end.

check(T, SortedTimes, K) ->
    InitialHeap = lists:foldl(fun(I, Acc) -> gb_trees:insert({0, I}, void, Acc) end, gb_trees:empty(), lists:seq(1, K)),

    check_potions(SortedTimes, T, InitialHeap).

check_potions([], _T, _Heap) ->
    true;
check_potions([PotionTime | RestTimes], T, Heap) ->
    {{MinFinishTime, WorkerId}, HeapWithoutMin} = gb_trees:take_min(Heap),

    if
        MinFinishTime + PotionTime > T ->
            false;
        true ->
            NewFinishTime = MinFinishTime + PotionTime,
            NewHeap = gb_trees:insert({NewFinishTime, WorkerId}, void, HeapWithoutMin),
            check_potions(RestTimes, T, NewHeap)
    end.