-module(pivot_index).
-export([pivot_index/1]).

pivot_index(Nums) ->
    Total = lists:sum(Nums),
    pivot_index(Nums, 0, 0, Total).

pivot_index([], _, _, _) ->
    -1;
pivot_index([H|T], Index, LeftSum, Total) ->
    RightSum = Total - LeftSum - H,
    if
        LeftSum == RightSum ->
            Index;
        true ->
            pivot_index(T, Index + 1, LeftSum + H, Total)
    end.