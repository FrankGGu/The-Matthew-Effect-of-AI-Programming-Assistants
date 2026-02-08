-module(solution).
-export([even_odd_bits/1]).

even_odd_bits(N) ->
    even_odd_bits_helper(N, 0, 0, 0).

even_odd_bits_helper(0, _Index, EvenCount, OddCount) ->
    [EvenCount, OddCount];
even_odd_bits_helper(N, Index, EvenCount, OddCount) ->
    Bit = N band 1,
    NewN = N bsr 1,
    NewIndex = Index + 1,

    IsIndexEven = (Index band 1 == 0),

    case {IsIndexEven, Bit == 1} of
        {true, true} ->
            even_odd_bits_helper(NewN, NewIndex, EvenCount + 1, OddCount);
        {true, false} ->
            even_odd_bits_helper(NewN, NewIndex, EvenCount, OddCount);
        {false, true} ->
            even_odd_bits_helper(NewN, NewIndex, EvenCount, OddCount + 1);
        {false, false} ->
            even_odd_bits_helper(NewN, NewIndex, EvenCount, OddCount)
    end.