-module(solution).
-export([satisfies_neighboring_bitwise_xor/1]).

satisfies_neighboring_bitwise_xor(Derived) ->
    XorSum = lists:foldl(fun(X, Acc) -> X bxor Acc end, 0, Derived),
    XorSum == 0.