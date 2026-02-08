-module(solution).
-export([result_array/2]).

result_array(Nums, K) ->
    lists:foldl(fun _ -> multiply_and_append(Nums) end, Nums, lists:seq(1, K)).

multiply_and_append(Nums) ->
    [lists:append(Nums, [lists:last(Nums) * 2])].