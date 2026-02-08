-module(solution).
-export([removeElement/2]).

removeElement(Nums, Val) ->
    FilteredNums = lists:filter(fun(X) -> X =/= Val end, Nums),
    length(FilteredNums).