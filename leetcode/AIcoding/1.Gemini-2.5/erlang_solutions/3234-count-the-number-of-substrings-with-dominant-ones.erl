-module(solution).
-export([solve/1]).

bit_update(Index, Value, BitArray, Size) ->
    bit_update_loop(Index + 1, Value, BitArray, Size).

bit_update_loop(Idx, Value, BitArray, Size) ->
    if Idx =< Size ->
        CurrentVal = array:get(Idx - 1, BitArray),
        NewBitArray = array:set(Idx - 1, CurrentVal + Value, BitArray),
        bit_update_loop(Idx + (Idx band -Idx), Value, NewBitArray, Size);
    true ->
        BitArray
    end.

bit_query(Index, BitArray) ->
    bit_query_loop(Index + 1, BitArray, 0).

bit_query_loop(Idx, BitArray, Sum) ->
    if Idx > 0 ->
        CurrentVal = array:get(Idx - 1, BitArray),
        bit_query_loop(Idx - (Idx band -Idx), BitArray, Sum + CurrentVal);
    true ->
        Sum
    end.

solve(S) ->
    N = length(S),

    %% MaxBalance represents the maximum possible absolute balance (N).
    %% We map balance values (from -N to N) to array indices (from 0 to 2*N).
    %% A balance of 'Val' is mapped to array index 'Val + MaxBalance'.
    MaxBalance = N, 
    BitArraySize = 2 * MaxBalance + 1,
    InitialBitArray = array:new(BitArraySize, 0),

    %% Initialize BIT with diff[0] = 0.
    %% This corresponds to the empty prefix, which has a balance of 0.
    %% Map 0 to index '0 + MaxBalance'.
    UpdatedBitArray0 = bit_update(0 + MaxBalance, 1, InitialBitArray, BitArraySize),

    count_substrings(S, UpdatedBitArray0, 0, 0, MaxBalance, BitArraySize).

count_substrings([], _BitArray, _CurrentBalance, TotalCount, _MaxBalance, _BitArraySize) ->
    TotalCount;
count_substrings([H|T], BitArray, CurrentBalance, TotalCount, MaxBalance, BitArraySize) ->
    %% Calculate the balance for the prefix ending at the current character
    NewBalance = case H of
        $1 -> CurrentBalance + 1;
        $0 -> CurrentBalance - 1
    end,

    %% We need to count 'i' such that diff[j+1] > diff[i].
    %% diff[j+1] is NewBalance. diff[i] are previous balances.
    %% So we query the BIT for all previous balances strictly less than NewBalance.
    %% This means querying up to (NewBalance - 1).
    %% Map (NewBalance - 1) to its corresponding array index.
    QueryIndex = (NewBalance - 1) + MaxBalance,

    %% bit_query handles indices < 0 correctly (returns 0).
    %% Max QueryIndex for N=10^5 is (10^5-1)+10^5 = 2*10^5-1.
    %% BitArraySize is 2*10^5+1. So max QueryIndex is always < BitArraySize-1.
    %% No need for min/max clamping.
    CountSmallerDiffs = bit_query(QueryIndex, BitArray),

    NewTotalCount = TotalCount + CountSmallerDiffs,

    %% Add the current NewBalance to the BIT for future queries.
    %% Map NewBalance to its corresponding array index.
    UpdateIndex = NewBalance + MaxBalance,
    UpdatedBitArray = bit_update(UpdateIndex, 1, BitArray, BitArraySize),

    count_substrings(T, UpdatedBitArray, NewBalance, NewTotalCount, MaxBalance, BitArraySize).