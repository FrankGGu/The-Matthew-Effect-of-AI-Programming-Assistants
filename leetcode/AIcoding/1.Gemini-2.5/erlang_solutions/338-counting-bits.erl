-module(solution).
-export([countBits/1]).

countBits(N) ->
    countBits_helper(N, []).

countBits_helper(-1, Acc) ->
    Acc;
countBits_helper(I, Acc) ->
    SetBits = count_set_bits(I),
    countBits_helper(I - 1, [SetBits | Acc]).

count_set_bits(0) ->
    0;
count_set_bits(N) when N > 0 ->
    1 + count_set_bits(N band (N - 1)).