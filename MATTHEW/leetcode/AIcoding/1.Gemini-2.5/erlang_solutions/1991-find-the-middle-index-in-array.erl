-module(solution).
-export([find_middle_index/1]).

find_middle_index(Nums) ->
    TotalSum = lists:sum(Nums),
    find_middle_index_recursive(Nums, TotalSum, 0, 0).

find_middle_index_recursive([], _TotalSum, _Index, _CurrentLeftSum) ->
    -1;
find_middle_index_recursive([H|T], TotalSum, Index, CurrentLeftSum) ->
    RightSum = TotalSum - CurrentLeftSum - H,
    if
        CurrentLeftSum == RightSum ->
            Index;
        true ->
            find_middle_index_recursive(T, TotalSum, Index + 1, CurrentLeftSum + H)
    end.