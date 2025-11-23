-module(solution).
-export([permute/1]).

permute(Nums) ->
    lists:permutations(Nums).