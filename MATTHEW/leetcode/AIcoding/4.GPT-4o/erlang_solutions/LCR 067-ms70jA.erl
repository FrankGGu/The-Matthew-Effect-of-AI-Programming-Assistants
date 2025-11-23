-module(solution).
-export([findMaximumXOR/1]).

findMaximumXOR(Numbers) ->
    MaxXor = lists:foldl(fun(X, Acc) -> lists:foldl(fun(Y, InnerAcc) -> max(InnerAcc, X bxor Y) end, Acc, Numbers) end, 0, Numbers),
    MaxXor.