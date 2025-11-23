-module(solution).
-export([findDisappearedNumbers/1]).

findDisappearedNumbers(Nums) ->
    N = length(Nums),
    FullSet = sets:from_list(lists:seq(1, N)),
    NumsSet = sets:from_list(Nums),
    DiffSet = sets:subtract(FullSet, NumsSet),
    sets:to_list(DiffSet).