-module(largest_sum_of_averages).
-export([largestSumOfAverages/2]).

largestSumOfAverages(Prices, K) ->
    N = length(Prices),
    DP = array:new(N+1, {default, 0.0}),
    Prefix = array:new(N+1, {default, 0.0}),
    lists:foreach(fun(I) -> array:set(I+1, array:get(I, Prefix) + lists:nth(I, Prices), Prefix) end, lists:seq(1, N)),
    lists:foreach(fun(I) -> array:set(I, array:get(I, Prefix), DP) end, lists:seq(1, N)),
    lists:foreach(fun(I) -> 
        lists:foreach(fun(J) -> 
            if J < I ->
                Avg = (array:get(I, Prefix) - array:get(J, Prefix)) / (I - J),
                array:set(I, max(array:get(I, DP), array:get(J, DP) + Avg), DP);
            true -> ok
            end
        end, lists:seq(0, I-1))
    end, lists:seq(1, N)),
    array:get(N, DP).