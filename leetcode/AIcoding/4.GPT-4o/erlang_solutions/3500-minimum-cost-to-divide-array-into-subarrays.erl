-module(solution).
-export([min_cost/1]).

min_cost(Nums) ->
    N = length(Nums),
    dp(Nums, N, 0, []).

dp(_, 0, Cost, _) ->
    Cost;
dp(Nums, N, Cost, Seen) ->
    NewCost = lists:foldl(fun(X, Acc) -> 
        case lists:any(fun(Y) -> X == Y end, Seen) of
            true -> Acc;
            false -> Acc + X
        end
    end, Cost, Nums),
    dp(Nums, N - 1, NewCost, [lists:nth(N - 1, Nums) | Seen]).