-module(reverse_bits).
-export([reverse_bits/1]).

reverse_bits(N) ->
    reverse_bits(N, 0, 31).

reverse_bits(0, Acc, _) ->
    Acc;
reverse_bits(N, Acc, Shift) ->
    Bit = N band 1,
    NewAcc = (Acc bsl 1) bor Bit,
    reverse_bits(N bsr 1, NewAcc, Shift - 1).