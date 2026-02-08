-module(solution).
-export([neighboring_bitwise_xor/1]).

neighboring_bitwise_xor(N) when N >= 1, N =< 1000 ->
    P = lists:seq(0, N - 1),
    lists:map(fun(X) -> lists:foldl(fun(Y, Acc) -> Acc bxor (X bxor Y) end, 0, P) end, P).