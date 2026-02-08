-module(solution).
-export([find_disappeared_numbers/1]).

find_disappeared_numbers(Nums) ->
    N = length(Nums),
    lists:seq(1, N) -- Nums.