-module(reverse_bits).
-export([reverse_bits/1]).

reverse_bits(N) ->
    reverse_bits_helper(N, 0, 32).

reverse_bits_helper(_, Acc, 0) ->
    Acc;
reverse_bits_helper(N, Acc, Count) ->
    LSB = N band 1,
    NewAcc = (Acc bsl 1) bor LSB,
    reverse_bits_helper(N bsr 1, NewAcc, Count - 1).