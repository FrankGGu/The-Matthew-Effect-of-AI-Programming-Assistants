-module(solution).
-export([left_right_difference/1]).

left_right_difference(Nums) ->
    TotalSum = lists:sum(Nums),
    lists:map(fun(X) -> abs(TotalSum - 2 * X) end, Nums).