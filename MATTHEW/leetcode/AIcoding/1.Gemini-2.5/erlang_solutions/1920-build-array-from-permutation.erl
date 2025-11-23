-module(solution).
-export([build_array/1]).

build_array(Nums) ->
    Len = length(Nums),
    [lists:nth(lists:nth(I + 1, Nums) + 1, Nums) || I <- lists:seq(0, Len - 1)].