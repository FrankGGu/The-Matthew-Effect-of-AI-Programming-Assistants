-module(count_bits).
-export([count_bits/1]).

count_bits(N) ->
    lists:map(fun(X) -> count_set_bits(X) end, lists:seq(0, N)).

count_set_bits(0) ->
    0;
count_set_bits(N) ->
    count_set_bits(N band (N - 1)) + 1.