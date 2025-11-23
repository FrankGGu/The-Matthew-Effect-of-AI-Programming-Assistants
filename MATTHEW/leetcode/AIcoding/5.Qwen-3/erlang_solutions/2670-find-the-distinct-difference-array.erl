-module(solution).
-export([distinct_difference/1]).

distinct_difference(Nums) ->
    N = length(Nums),
    Left = lists:seq(0, N-1),
    Right = lists:seq(N-1, 0, -1),
    lists:map(fun(I) -> 
        LeftCount = length(lists:usort(lists:sublist(Nums, 1, I+1))),
        RightCount = length(lists:usort(lists:sublist(Nums, I+2, N-I-1))),
        LeftCount - RightCount
    end, Left).