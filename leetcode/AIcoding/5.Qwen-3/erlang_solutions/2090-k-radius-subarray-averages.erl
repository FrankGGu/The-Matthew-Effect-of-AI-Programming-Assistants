-module(k_radius_subarray_averages).
-export([results_array/2]).

results_array(Nums, K) ->
    N = length(Nums),
    Result = lists:seq(0, N-1),
    lists:map(fun(I) -> average(I, Nums, K, N) end, Result).

average(I, Nums, K, N) ->
    Start = I - K,
    End = I + K,
    if
        Start < 0 -> -1;
        End >= N -> -1;
        true ->
            Sub = lists:sublist(Nums, Start+1, End - Start + 1),
            Sum = lists:sum(Sub),
            trunc(Sum / (End - Start + 1))
    end.