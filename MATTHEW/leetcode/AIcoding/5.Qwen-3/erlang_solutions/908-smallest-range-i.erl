-module(small_range_i).
-export([solve/1]).

solve(Nums) ->
    Min = lists:min(Nums),
    Max = lists:max(Nums),
    if
        Max - Min =< 0 -> 0;
        true -> Max - Min
    end.