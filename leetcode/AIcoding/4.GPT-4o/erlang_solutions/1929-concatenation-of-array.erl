-module(solution).
-export([get_concatenation/1]).

get_concatenation(Nums) ->
    N = length(Nums),
    Nums ++ Nums.