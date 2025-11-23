-module(solution).
-export([minimumOperations/1]).

minimumOperations(Nums) ->
    PositiveNums = [X || X <- Nums, X > 0],
    Set = sets:from_list(PositiveNums),
    sets:size(Set).