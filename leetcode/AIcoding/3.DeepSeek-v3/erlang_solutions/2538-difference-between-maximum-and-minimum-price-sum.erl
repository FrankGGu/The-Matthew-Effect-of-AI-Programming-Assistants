-module(solution).
-export([max_price_sum_diff/1]).

max_price_sum_diff(Prices) ->
    N = length(Prices),
    if 
        N =:= 1 -> 0;
        true ->
            MaxSum = lists:max(Prices),
            MinSum = lists:min(Prices),
            MaxSum - MinSum
    end.