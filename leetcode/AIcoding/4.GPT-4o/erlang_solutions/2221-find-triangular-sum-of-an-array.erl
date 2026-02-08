-module(solution).
-export([triangularSum/1]).

triangularSum(Array) ->
    N = length(Array),
    triangular_sum(Array, N).

triangular_sum(Array, 1) -> 
    hd(Array);
triangular_sum(Array, N) ->
    NewArray = lists:map(fun(X, Y) -> rem(X + Y, 10) end, Array, tl(Array)),
    triangular_sum(NewArray, N - 1).