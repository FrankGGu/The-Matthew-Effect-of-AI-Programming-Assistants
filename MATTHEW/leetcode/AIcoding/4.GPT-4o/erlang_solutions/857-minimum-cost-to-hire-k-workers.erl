-module(solution).
-export([min_cost/3]).

min_cost(quality, wage, K) ->
    Workers = lists:zip(quality, wage),
    SortedWorkers = lists:sort(fun({Q1, W1}, {Q2, W2}) -> 
        W1 * Q2 < W2 * Q1 
    end, Workers),
    min_cost_helper(SortedWorkers, K, 0, 0, []).

min_cost_helper([], _, _, _, Acc) -> 
    lists:sum(Acc);
min_cost_helper([{Q, W} | Rest], K, TotalQuality, TotalWage, Acc) ->
    NewQuality = TotalQuality + Q,
    NewWage = W,
    NewAcc = [NewWage * K / NewQuality | Acc],
    if 
        length(Acc) < K -> 
            min_cost_helper(Rest, K, NewQuality, NewWage, NewAcc);
        true ->
            MinAcc = lists:min(Acc),
            min_cost_helper(Rest, K, NewQuality, NewWage, NewAcc) 
    end.