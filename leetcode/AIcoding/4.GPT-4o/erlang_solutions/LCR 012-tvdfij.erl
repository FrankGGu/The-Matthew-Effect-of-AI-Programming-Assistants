-module(solution).
-export([pivot_index/1]).

pivot_index(Nums) ->
    Total = lists:sum(Nums),
    pivot_index_helper(Nums, Total, 0, 0).

pivot_index_helper([], _, _, _) -> -1;
pivot_index_helper([H | T], Total, LeftSum, Index) ->
    if
        LeftSum =:= Total - LeftSum - H -> Index;
        true -> pivot_index_helper(T, Total, LeftSum + H, Index + 1)
    end.