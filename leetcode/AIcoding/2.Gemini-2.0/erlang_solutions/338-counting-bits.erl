-module(counting_bits).
-export([countBits/1]).

countBits(N) ->
    lists:map(fun(I) -> countBitsHelper(I) end, lists:seq(0, N)).

countBitsHelper(0) -> 0;
countBitsHelper(N) ->
    (N band 1) + countBitsHelper(N bsr 1).