-module(solution).
-export([min_swaps_alternating_binary_string/1]).

min_swaps_alternating_binary_string(S) ->
    N = length(S),
    {Count0, Count1, Diff0Even, Diff1Even, Diff0Odd, Diff1Odd} = count_chars_and_positions(S),

    AbsDiff = abs(Count0 - Count1),
    if
        AbsDiff > 1 ->
            -1;
        true ->
            try_patterns(N, Count0, Count1, Diff0Even, Diff1Even, Diff0Odd, Diff1Odd)
    end.

count_chars_and_positions(S) ->
    count_chars_and_positions(S, 0, 0, 0, 0, 0, 0, 0).

count_chars_and_positions([], _Idx, Count0, Count1, D0E, D1E, D0O, D1O) ->
    {Count0, Count1, D0E, D1E, D0O, D1O};
count_chars_and_positions([H|T], Idx, Count0, Count1, D0E, D1E, D0O, D1O) ->
    Char = H,
    IsEvenIdx = (Idx rem 2 == 0),

    NewCount0 = if Char == $0 -> Count0 + 1; true -> Count0 end,
    NewCount1 = if Char == $1 -> Count1 + 1; true -> Count1 end,

    NewD0E = if Char == $0 andalso IsEvenIdx -> D0E + 1; true -> D0E end,
    NewD1E = if Char == $1 andalso IsEvenIdx -> D1E + 1; true -> D1E end,
    NewD0O = if Char == $0 andalso not IsEvenIdx -> D0O + 1; true -> D0O end,
    NewD1O = if Char == $1 andalso not IsEvenIdx -> D1O + 1; true -> D1O end,

    count_chars_and_positions(T, Idx + 1, NewCount0, NewCount1, NewD0E, NewD1E, NewD0O, NewD1O).

try_patterns(N, Count0, Count1, Diff0Even, Diff1Even, Diff0Odd, Diff1Odd) ->
    Target0_01 = (N + 1) div 2,
    Target1_01 = N div 2,

    Swaps01 = if
        Count0 == Target0_01 andalso Count1 == Target1_01 ->
            Diff1Even;
        true ->
            -1
    end,

    Target0_10 = N div 2,
    Target1_10 = (N + 1) div 2,

    Swaps10 = if
        Count0 == Target0_10 andalso Count1 == Target1_10 ->
            Diff0Even;
        true ->
            -1
    end,

    if
        Swaps01 == -1 andalso Swaps10 == -1 ->
            -1;
        Swaps01 == -1 ->
            Swaps10;
        Swaps10 == -1 ->
            Swaps01;
        true ->
            min(Swaps01, Swaps10)
    end.