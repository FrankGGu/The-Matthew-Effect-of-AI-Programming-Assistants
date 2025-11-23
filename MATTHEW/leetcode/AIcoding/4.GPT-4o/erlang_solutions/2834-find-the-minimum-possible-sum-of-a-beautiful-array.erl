-module(solution).
-export([min_beautiful_sum/1]).

min_beautiful_sum(N) ->
    Sum = fun(N, K) when N > 0 ->
        if 
            K * (K + 1) div 2 =< N -> 
                K + Sum(N - K * (K + 1) div 2, K + 1);
            true -> 
                0
        end
    end,
    Sum(N, 1).