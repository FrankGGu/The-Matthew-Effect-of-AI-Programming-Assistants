-module(solution).
-export([min_operations/1]).

min_operations(null) -> 0;
min_operations(Root) ->
    bfs_loop([Root], 0).

bfs_loop([], AccSwaps) ->
    AccSwaps;
bfs_loop(CurrentLevelNodes, AccSwaps) ->
    {LevelValues, NextLevelChildren} = extract_level_info(CurrentLevelNodes, [], []),

    SwapsForThisLevel = if 
                            length(LevelValues) > 1 -> 
                                min_swaps(LevelValues);
                            true -> 
                                0 
                        end,

    NewAccSwaps = AccSwaps + SwapsForThisLevel,
    bfs_loop(NextLevelChildren, NewAccSwaps).

extract_level_info([#'TreeNode'{val = V, left = L, right = R} | Rest], ValuesAcc, ChildrenAcc) ->
    NewValuesAcc = [V | ValuesAcc],
    NewChildrenAcc = add_children(L, R, ChildrenAcc),
    extract_level_info(Rest, NewValuesAcc, NewChildrenAcc);
extract_level_info([], ValuesAcc, ChildrenAcc) ->
    {lists:reverse(ValuesAcc), lists:reverse(ChildrenAcc)}.

add_children(L, R, Acc) ->
    Acc1 = case L of 
             #'TreeNode'{} -> [L | Acc]; 
             _ -> Acc 
           end,
    Acc2 = case R of 
             #'TreeNode'{} -> [R | Acc1]; 
             _ -> Acc1 
           end,
    Acc2.

min_swaps(List) ->
    N = length(List),
    IndexedList = lists:zip(List, lists:seq(0, N-1)),
    SortedIndexedList = lists:sort(IndexedList),

    TargetOriginalIndices = [OriginalIndex || {_, OriginalIndex} <- SortedIndexedList],

    Arr = array:from_list(TargetOriginalIndices),
    Visited = array:new([{size, N}, {default, false}]),

    cycle_sort_loop(0, N, Arr, Visited, 0).

cycle_sort_loop(I, N, Arr, Visited, TotalSwaps) when I < N ->
    case array:get(I, Visited) of
        true ->
            cycle_sort_loop(I + 1, N, Arr, Visited, TotalSwaps);
        false ->
            {NewVisited, CycleSize} = find_cycle(I, I, Arr, Visited, 0),
            NewTotalSwaps = TotalSwaps + (CycleSize - 1),
            cycle_sort_loop(I + 1, N, Arr, NewVisited, NewTotalSwaps)
    end;
cycle_sort_loop(_I, _N, _Arr, _Visited, TotalSwaps) ->
    TotalSwaps.

find_cycle(StartNode, CurrentNode, Arr, Visited, CycleSize) ->
    Visited1 = array:set(CurrentNode, true, Visited),
    NextNode = array:get(CurrentNode, Arr),

    if 
        NextNode == StartNode ->
            {Visited1, CycleSize + 1};
        true ->
            find_cycle(StartNode, NextNode, Arr, Visited1, CycleSize + 1)
    end.