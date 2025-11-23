-module(solution).
-export([xor_operation/2]).

xor_operation(0, _) -> 0;
xor_operation(N, X) ->
    xor_operation(N - 1, X) bxor (X + N - 1).