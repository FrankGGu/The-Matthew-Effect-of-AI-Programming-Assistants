-module(solution).
-export([minimumOperations/1]).

minimumOperations(Nums) ->
    PositiveUnique = lists:filter(fun(X) -> X > 0 end, lists:usort(Nums)),
    length(PositiveUnique).