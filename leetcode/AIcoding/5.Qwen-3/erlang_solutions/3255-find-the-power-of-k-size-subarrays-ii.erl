-module(solution).
-export([find_power/1]).

find_power(Nums) ->
    N = length(Nums),
    Result = lists:seq(0, N-1),
    lists:map(fun(I) -> power(Nums, I) end, Result).

power(Nums, I) ->
    K = I + 1,
    N = length(Nums),
    Sub = lists:sublist(Nums, I+1, K),
    Max = lists:max(Sub),
    Min = lists:min(Sub),
    Max - Min.