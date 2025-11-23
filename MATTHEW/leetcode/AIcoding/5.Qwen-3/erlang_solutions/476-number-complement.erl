-module(number_complement).
-export([find_complement/1]).

find_complement(N) ->
    find_complement(N, 0, 0).

find_complement(0, _, Acc) ->
    Acc;
find_complement(N, Shift, Acc) ->
    Bit = N band 1,
    NewAcc = Acc bor (1 bsl Shift) * (1 - Bit),
    find_complement(N bsr 1, Shift + 1, NewAcc).