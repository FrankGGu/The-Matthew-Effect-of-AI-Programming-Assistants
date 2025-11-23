-module(solution).
-export([min_operations/1]).

min_operations(Nums) ->
    min_operations(Nums, 0).

min_operations([], Count) ->
    Count;
min_operations(Nums, Count) ->
    case lists:max(Nums) of
        0 ->
            Count;
        Max ->
            NewNums = lists:map(fun(X) -> if X >= Max -> X - Max; true -> X end end, Nums),
            min_operations(NewNums, Count + 1)
    end.