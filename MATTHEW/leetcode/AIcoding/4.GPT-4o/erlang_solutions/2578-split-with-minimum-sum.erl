-module(solution).
-export([split_into_min_sum/1]).

split_into_min_sum(N) ->
    lists:foldl(fun(X, Acc) -> 
        {H, T} = Acc,
        {H + div(X, 2), T + div(X + 1, 2)}
    end, {0, 0}, lists:seq(1, N)).