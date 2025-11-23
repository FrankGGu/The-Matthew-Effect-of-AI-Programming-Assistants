-module(solution).
-export([judge_square_sum/1]).

judge_square_sum(N) ->
    Max = trunc(math:sqrt(N)),
    lists:any(fun(I) -> 
        J = trunc(math:sqrt(N - I * I)),
        I * I + J * J =:= N 
    end, lists:seq(0, Max)).