-module(solution).
-export([min_cost/2]).

min_cost(PointA, PointB) ->
    A = length(PointA),
    B = length(PointB),
    max_val = 10000 * 10000,
    Cost = lists:duplicate(A * B, max_val),
    Cost = lists:map(fun(_) -> lists:duplicate(A * B, max_val) end, lists:seq(1, A)),
    Cost = lists:foldl(fun({XA, YA}, Acc) ->
        lists:foldl(fun({XB, YB}, Acc2) ->
            CostXY = abs(XA - XB) + abs(YA - YB),
            Acc3 = lists:map(fun({C, X, Y}) -> if X == XA andalso Y == XB -> CostXY; true -> C end end, Acc2),
            Acc3
        end, Acc, PointB)
    end, Cost, PointA),
    min_cost_helper(Cost, A, B).

min_cost_helper(Cost, A, B) ->
    N = 1 bsl B,
    lists:foldl(fun(I, Acc) -> 
        lists:foldl(fun(J, Acc2) -> 
            Total = lists:foldl(fun(X, Acc3) -> 
                Acc3 + (Cost element(I, X))
            end, 0, lists:seq(0, A - 1)),
            min(Acc2, Total)
        end, Acc, lists:seq(0, N - 1))
    end, 1000000, lists:seq(1, N - 1)).