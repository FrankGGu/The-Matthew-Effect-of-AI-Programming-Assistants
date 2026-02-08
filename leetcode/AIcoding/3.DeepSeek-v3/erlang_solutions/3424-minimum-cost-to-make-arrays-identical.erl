-module(solution).
-export([min_cost/2]).

min_cost(Nums, Target) ->
    {SumNums, SumTarget} = {lists:sum(Nums), lists:sum(Target)},
    if
        SumNums =/= SumTarget -> -1;
        true ->
            lists:sum([abs(N - T) || {N, T} <- lists:zip(Nums, Target)])
    end.