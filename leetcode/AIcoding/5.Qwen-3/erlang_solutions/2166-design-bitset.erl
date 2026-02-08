-module(bitset).
-export([new/1, set/2, flip/1, isOne/2, size/1, count/1]).

new(N) ->
    {bitset, N, 0, 0}.

set(Bit, {bitset, N, Data, FlipCount}) ->
    case Bit < N of
        true ->
            NewData = Data band (bnot (1 bsl Bit)),
            {bitset, N, NewData, FlipCount};
        false ->
            {bitset, N, Data, FlipCount}
    end.

flip({bitset, N, Data, FlipCount}) ->
    NewFlipCount = FlipCount + 1,
    NewData = Data bxor ((1 bsl N) - 1),
    {bitset, N, NewData, NewFlipCount}.

isOne(Bit, {bitset, N, Data, FlipCount}) ->
    case Bit < N of
        true ->
            IsFlipped = (FlipCount rem 2) == 1,
            if
                IsFlipped ->
                    (Data band (1 bsl Bit)) == 0;
                true ->
                    (Data band (1 bsl Bit)) /= 0
            end;
        false ->
            false
    end.

size({bitset, N, _, _}) ->
    N.

count({bitset, N, Data, FlipCount}) ->
    IsFlipped = (FlipCount rem 2) == 1,
    if
        IsFlipped ->
            N - bit_count(Data);
        true ->
            bit_count(Data)
    end.

bit_count(0) -> 0;
bit_count(N) -> 1 + bit_count(N band (N - 1)).