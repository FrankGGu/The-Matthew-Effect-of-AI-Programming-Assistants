-module(solution).
-export([pivot_index/1]).

pivot_index(Nums) ->
    Total = lists:sum(Nums),
    pivot_index_helper(Nums, Total, 0, 0).

pivot_index_helper([], _, _, _) ->
    -1;
pivot_index_helper([H | T], Total, LeftSum, Index) ->
    NewLeftSum = LeftSum + H,
    RightSum = Total - NewLeftSum - H,
    if
        NewLeftSum =:= RightSum -> Index;
        true -> pivot_index_helper(T, Total, NewLeftSum, Index + 1)
    end.