-module(solution).
-export([maximize_xor/2]).

maximize_xor(Array, Queries) ->
    MaxXor = fun(X, Y) -> X bxor Y end,
    lists:map(fun(Query) -> lists:max(lists:map(fun(A) -> MaxXor(Query, A) end, Array)) end, Queries).