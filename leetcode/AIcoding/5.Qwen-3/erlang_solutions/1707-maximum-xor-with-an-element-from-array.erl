-module(solution).
-export([max_xor/2]).

max_xor(A, Q) ->
    lists:map(fun(Qi) -> max_xor_query(A, Qi) end, Q).

max_xor_query(A, X) ->
    lists:foldl(fun(Num, Acc) -> max(Acc, band(Num, X)) end, 0, A).