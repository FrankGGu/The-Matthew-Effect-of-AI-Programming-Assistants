-module(solution).
-export([maximum_strong_pair_xor/2]).

maximum_strong_pair_xor(N, A) ->
    Max = lists:max(A),
    lists:foldl(fun(X, Acc) -> max(Acc, Max bxor X) end, 0, A).