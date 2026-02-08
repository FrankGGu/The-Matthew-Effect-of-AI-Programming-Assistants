-module(solution).
-export([find_middle_index/1]).

find_middle_index(Nums) ->
    TotalSum = lists:sum(Nums),
    find_index(Nums, TotalSum, 0, 0).

find_index([], _, _, _) -> -1;
find_index([H | T], TotalSum, LeftSum, Index) ->
    RightSum = TotalSum - LeftSum - H,
    if
        LeftSum == RightSum -> Index;
        true -> find_index(T, TotalSum, LeftSum + H, Index + 1)
    end.