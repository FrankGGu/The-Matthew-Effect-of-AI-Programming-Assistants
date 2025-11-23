-module(solution).
-export([min_adjacent_swaps/2]).

min_adjacent_swaps(Numbers, K) ->
    Sorted = lists:sort(Numbers),
    KthSmallest = lists:nth(K, Sorted),
    Index = lists:position(KthSmallest, Numbers) - 1,
    swap(Numbers, Index, 0).

swap(List, Index, Count) when Index < length(List) ->
    case lists:nth(Index + 1, List) of
        Next when Next < lists:nth(Index, List) ->
            NewList = swap_elements(List, Index, Index + 1),
            swap(NewList, Index + 1, Count + 1);
        _ ->
            Count
    end.

swap_elements(List, I, J) ->
    {BeforeI, [ElemI | AfterI]} = lists:split(I, List),
    {BeforeJ, [ElemJ | AfterJ]} = lists:split(J - I - 1, AfterI),
    BeforeI ++ [ElemJ] ++ BeforeJ ++ [ElemI] ++ AfterJ.