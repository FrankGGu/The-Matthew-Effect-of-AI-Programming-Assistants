-module(hire_k_workers).
-export([min_cost/2]).

min_cost(Workers, K) ->
    Sorted = lists:sort(fun({W1, C1}, {W2, C2}) -> W1 < W2 end, Workers),
    WorkList = [C || {_, C} <- Sorted],
    CostList = [0 || _ <- WorkList],
    min_cost(Sorted, WorkList, CostList, K, 0, 0).

min_cost(_, _, _, 0, Total, _) -> Total;
min_cost([], _, _, _, _, _) -> 0;
min_cost([Worker | Rest], WorkList, CostList, K, Total, Index) ->
    [CurrentCost | RestCost] = CostList,
    NewTotal = Total + CurrentCost,
    min_cost(Rest, WorkList, RestCost, K-1, NewTotal, Index+1).