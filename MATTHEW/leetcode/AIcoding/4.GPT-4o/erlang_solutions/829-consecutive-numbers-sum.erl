-module(solution).
-export([consecutive_numbers_sum/1]).

consecutive_numbers_sum(N) ->
    Count = 0,
    MaxK = trunc(math:sqrt(2 * N)),
    lists:foldl(fun(K, Acc) ->
        if
            (2 * N) rem K == 0 -> 
                Acc + 1;
            true -> 
                Acc
        end
    end, Count, lists:seq(1, MaxK)).