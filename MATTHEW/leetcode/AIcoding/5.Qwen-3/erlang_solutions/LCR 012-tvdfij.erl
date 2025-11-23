-module(solution).
-export([pivot_index/1]).

pivot_index(Nums) ->
    pivot_index(Nums, 0, 0, lists:sum(Nums)).

pivot_index([], _, _, _) ->
    -1;
pivot_index([H | T], Index, LeftSum, RightSum) ->
    case LeftSum of
        LeftSum when LeftSum == RightSum - H ->
            Index;
        _ ->
            pivot_index(T, Index + 1, LeftSum + H, RightSum - H)
    end.