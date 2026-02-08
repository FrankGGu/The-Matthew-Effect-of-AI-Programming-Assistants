-module(solution).
-export([min_swaps/1]).

digit_sum(0) -> 0;
digit_sum(N) -> (N rem 10) + digit_sum(N div 10).

min_swaps(Nums) ->
    N = length(Nums),

    IndexedNums = lists:zip(lists:seq(0, N-1), Nums),

    DigitSumIndexedList = lists:map(fun({Idx, Val}) -> {digit_sum(Val), Idx} end, IndexedNums),

    SortedPairs = lists:sort(fun({DS_A, Idx_A}, {DS_B, Idx_B}) ->
                                   if DS_A < DS_B -> true;
                                      DS_A == DS_B -> Idx_A < Idx_B;
                                      true -> false
                                   end
                               end, DigitSumIndexedList),

    TargetPositionsList = lists:map(fun({_, OriginalIdx}) -> OriginalIdx end, SortedPairs),

    TargetArray = array:from_list(TargetPositionsList),

    find_cycles_and_swaps_recursive(0, N, TargetArray, array:new(N, {default, false}), 0).

find_cycles_and_swaps_recursive(I, N, TargetArray, VisitedArray, TotalSwaps) ->
    if I >= N ->
        TotalSwaps;
    else
        case array:get(I, VisitedArray) of
            true ->
                find_cycles_and_swaps_recursive(I + 1, N, TargetArray, VisitedArray, TotalSwaps);
            false ->
                {CycleLength, NewVisitedArray} = traverse_cycle(I, TargetArray, VisitedArray, 0),
                NewTotalSwaps = TotalSwaps + (CycleLength - 1),
                find_cycles_and_swaps_recursive(I + 1, N, TargetArray, NewVisitedArray, NewTotalSwaps)
        end
    end.

traverse_cycle(CurrentNode, TargetArray, CurrentVisitedArray, AccLength) ->
    case array:get(CurrentNode, CurrentVisitedArray) of
        true ->
            {AccLength, CurrentVisitedArray};
        false ->
            NewVisitedArray = array:set(CurrentNode, true, CurrentVisitedArray),
            NextNode = array:get(CurrentNode, TargetArray),
            traverse_cycle(NextNode, TargetArray, NewVisitedArray, AccLength + 1)
    end.