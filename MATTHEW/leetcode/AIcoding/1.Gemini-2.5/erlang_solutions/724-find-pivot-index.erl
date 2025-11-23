-module(solution).
-export([pivot_index/1]).

pivot_index(Nums) ->
    TotalSum = lists:sum(Nums),
    find_pivot_index_recursive(Nums, 0, 0, TotalSum).

find_pivot_index_recursive([H|T], Index, LeftSum, TotalSum) ->
    RightSum = TotalSum - LeftSum - H,
    if LeftSum == RightSum ->
        Index;
    true ->
        find_pivot_index_recursive(T, Index + 1, LeftSum + H, TotalSum)
    end;
find_pivot_index_recursive([], _Index, _LeftSum, _TotalSum) ->
    -1.