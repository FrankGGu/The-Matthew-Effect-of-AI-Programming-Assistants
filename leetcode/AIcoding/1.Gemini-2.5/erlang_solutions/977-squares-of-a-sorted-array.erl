-module(solution).
-export([sorted_squares/1]).

sorted_squares(Nums) ->
    Squared = lists:map(fun(X) -> X*X end, Nums),
    lists:sort(Squared).