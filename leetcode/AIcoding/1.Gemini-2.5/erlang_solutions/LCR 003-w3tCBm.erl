-module(solution).
-export([countBits/1]).

countBits(N) ->
    [count_set_bits(I) || I <- lists:seq(0, N)].

count_set_bits(0) -> 0;
count_set_bits(Num) ->
    count_set_bits(Num band (Num - 1)) + 1.