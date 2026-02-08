-module(solve).
-export([numSubarraysWithNonZeroProduct/1]).

numSubarraysWithNonZeroProduct(Bits) ->
    Count = 0,
    N = length(Bits),
    I = 0,
    numSubarraysWithNonZeroProduct(Bits, I, Count).

numSubarraysWithNonZeroProduct(_, N, Count) when N >= length(Bits) ->
    Count;
numSubarraysWithNonZeroProduct(Bits, I, Count) ->
    J = I,
    Current = 1,
    NewCount = Count,
    numSubarraysWithNonZeroProduct(Bits, I, J, Current, NewCount).

numSubarraysWithNonZeroProduct(_, _, J, _, Count) when J >= length(Bits) ->
    Count;
numSubarraysWithNonZeroProduct(Bits, I, J, Current, Count) ->
    Val = lists:nth(J + 1, Bits),
    if
        Val == 0 ->
            numSubarraysWithNonZeroProduct(Bits, I, J + 1, Current, Count);
        true ->
            NewCurrent = Current * Val,
            NewCount = Count + 1,
            numSubarraysWithNonZeroProduct(Bits, I, J + 1, NewCurrent, NewCount)
    end.

numSubarraysWithNonZeroProduct(Bits, I, Count) ->
    if
        I >= length(Bits) ->
            Count;
        true ->
            numSubarraysWithNonZeroProduct(Bits, I + 1, Count)
    end.