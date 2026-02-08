-module(solution).
-export([minimize_or/1]).

minimize_or(Numbers) ->
    N = length(Numbers),
    min_or(Numbers, N, 0).

min_or(_, 0, Acc) ->
    Acc;
min_or(Numbers, K, Acc) ->
    {Min, Rest} = lists:split(K-1, Numbers),
    MinVal = lists:min(Min),
    NewAcc = Acc bor MinVal,
    min_or(Rest, K-1, NewAcc).