-module(middle_index).
-export([findMiddleIndex/1]).

findMiddleIndex(Nums) ->
    Total = lists:sum(Nums),
    findMiddleIndex(Nums, 0, 0, Total).

findMiddleIndex([], _, _, _) ->
    -1;
findMiddleIndex([H|T], Index, LeftSum, Total) ->
    RightSum = Total - LeftSum - H,
    if
        LeftSum == RightSum ->
            Index;
        true ->
            findMiddleIndex(T, Index + 1, LeftSum + H, Total)
    end.