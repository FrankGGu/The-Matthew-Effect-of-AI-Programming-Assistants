-module(solution).
-export([reverseBits/1]).

reverseBits(N) ->
    reverse_bits_acc(N, 0, 0).

reverse_bits_acc(N, Acc, Count) when Count < 32 ->
    LSB = N band 1,
    NewAcc = (Acc bsl 1) bor LSB,
    NewN = N bsr 1,
    reverse_bits_acc(NewN, NewAcc, Count + 1);
reverse_bits_acc(_N, Acc, 32) ->
    Acc.