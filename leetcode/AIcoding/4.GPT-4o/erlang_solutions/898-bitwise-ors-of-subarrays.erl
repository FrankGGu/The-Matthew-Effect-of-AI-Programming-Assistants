-module(solution).
-export([subarray_bitwise_ors/1]).

subarray_bitwise_ors(A) ->
    N = length(A),
    Bits = lists:foldl(fun(X, Acc) -> lists:seq(0, 31) ++ Acc end, [], A),
    Unique = lists:foldl(fun(X, Acc) -> lists:orbitwise(Acc, X) end, [], Bits),
    lists:usort(Unique).

orbitwise(List, X) ->
    [Y bor X || Y <- List] ++ [X].