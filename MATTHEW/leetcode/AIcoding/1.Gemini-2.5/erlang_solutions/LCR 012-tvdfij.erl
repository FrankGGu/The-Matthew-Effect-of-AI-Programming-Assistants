-module(solution).
-export([pivot_index/1]).

pivot_index(Nums) ->
    TotalSum = lists:sum(Nums),
    find_pivot(Nums, 0, TotalSum, 0).

find_pivot([], _LeftSum, _TotalSum, _Index) ->
    -1;
find_pivot([H|T], LeftSum, TotalSum, Index) ->
    RightSum = TotalSum - LeftSum - H,
    if
        LeftSum == RightSum ->
            Index;
        true ->
            find_pivot(T, LeftSum + H, TotalSum, Index + 1)
    end.