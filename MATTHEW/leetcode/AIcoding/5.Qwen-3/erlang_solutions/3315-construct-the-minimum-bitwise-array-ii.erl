-module(solution).
-export([min_bitwise_array/1]).

min_bitwise_array(Nums) ->
    N = length(Nums),
    Result = lists:seq(1, N),
    lists:sort(Result).