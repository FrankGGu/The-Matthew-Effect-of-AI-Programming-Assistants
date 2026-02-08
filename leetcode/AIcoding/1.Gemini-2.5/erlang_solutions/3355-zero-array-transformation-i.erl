-module(solution).
-export([minimumOperations/1]).

minimumOperations(Nums) ->
    PositiveNums = [N || N <- Nums, N > 0],
    UniquePositiveNums = sets:from_list(PositiveNums),
    sets:size(UniquePositiveNums).